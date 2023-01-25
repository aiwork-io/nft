<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Gettemplate extends BaseEntity
{

    
    public function IGtTransmissionTemplate($url, $title, $content, $cid)
    {
        header("Content-Type: text/html; charset=utf-8");
        $root_path = $_SERVER['DOCUMENT_ROOT'] . $_SERVER['PHP_SELF'];
        $doc_path  = mb_substr($root_path, 0, mb_stripos($root_path, 'web/index.php'));
        //da($doc_path);
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/IGt.Push.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/IGt.AppMessage.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/IGt.APNPayload.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/template/IGt.BaseTemplate.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/IGt.Batch.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/utils/AppConditions.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/template/notify/IGt.Notify.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/template/IGt.APNTemplate.php');

        
        $data            = [];
        $data['anzhuo']  = $this->anzhuo($url, $title, $content, $cid);
        //$data['pingguo'] = $this->IGtTransmissionTemplateDemo($url, $title, $content, $cid);

        return $data;
    }

    
    public function anzhuo($url, $title, $content, $cid)
    {
        $template = new \IGtTransmissionTemplate();
        //appid
        $template->set_appId('g6WF9hW2cO7UsQDCqLOTfA');
        //appkey
        $template->set_appkey('IVVmTXddVa6mvS1z5ZSPR6');
        //content
        $payload    = '{"title":"' . $title . '","content":"' . $content . '","payload":"' . $url . '"}';
        $url_encode = urlencode($url);
        //android apk
        $anzhuobao='uni.UNI6324F5C';
        $intent     = 'intent:#Intent;action=android.intent.action.oppopush;launchFlags=0x14000000;component='.$anzhuobao.'/io.dcloud.PandoraEntry;S.UP-OL-SU=true;S.payload=' . $url_encode . ';end';

        $template->set_transmissionType(2);
        $template->set_transmissionContent($payload);
        $notify = new \IGtNotify();
        $notify->set_title($title);
        $notify->set_content($content);
        $notify->set_intent($intent);
        $notify->set_type(\NotifyInfo_type::_intent);
        //$notify->set_url("/pages/center/index");

        $template->set3rdNotifyInfo($notify);
        //appkey and MasterSecret
        $igt = new \IGeTui('http://sdk.open.api.igexin.com/apiex.htm', 'IVVmTXddVa6mvS1z5ZSPR6', 'xUs596G6PK9LYczebDe8E9');
        // STEP2：setting
        $message = new \IGtSingleMessage();
        $message->set_isOffline(true);
        $message->set_offlineExpireTime(60 * 60 * 1000);
        $message->set_data($template);

        $target = new \IGtTarget();
        //appid
        $target->set_appId("g6WF9hW2cO7UsQDCqLOTfA");
        $target->set_clientId($cid);
        
        $result = $igt->pushMessageToSingle($message, $target);

        return $result;
    }

    
    public function IGtTransmissionTemplateDemo($url, $title, $content, $cid)
    {
        //appkey and MasterSecret
        $igt      = new \IGeTui('http://sdk.open.api.igexin.com/apiex.htm', 'IVVmTXddVa6mvS1z5ZSPR6', 'xUs596G6PK9LYczebDe8E9');
        $template = new \IGtTransmissionTemplate();
        //appid
        $template->set_appId('g6WF9hW2cO7UsQDCqLOTfA');
        //appkey
        $template->set_appkey('IVVmTXddVa6mvS1z5ZSPR6');
        
        $payload    = '{"title":"' . $title . '","content":"' . $content . '","payload":"' . $url . '"}';
        $url_encode = urlencode($url);
        //android apk
        $anzhuobao='uni.UNI6324F5C';
        $intent     = 'intent:#Intent;action=android.intent.action.oppopush;launchFlags=0x14000000;component='.$anzhuobao.'/io.dcloud.PandoraEntry;S.UP-OL-SU=true;S.payload=' . $url_encode . ';end';

        $template->set_transmissionType(2);
        $template->set_transmissionContent($payload);
        //$template->set_duration(BEGINTIME,ENDTIME);
        
        $template = new \IGtAPNTemplate();
        //        $apn                = new \IGtAPNPayload();
        //        $alertmsg           = new \SimpleAlertMsg();
        //        $alertmsg->alertMsg = $title;
        //        //$alertmsg->body=$content;
        //        $apn->alertMsg = $alertmsg;
        //        $apn->badge    = 2;
        //        $apn->sound    = "";
        //        $apn->add_customMsg($payload, $payload);
        //        $apn->contentAvailable = $content;
        //        $apn->category         = "ACTIONABLE";
        //        $template->set_apnInfo($apn);
        $notify = new \IGtNotify();
        $notify->set_title($title);
        $notify->set_content($content);
        $notify->set_intent($intent);
        $notify->set_type(\NotifyInfo_type::_intent);
        //$message = new \IGtSingleMessage();
        //  APN
        $apn                    = new \IGtAPNPayload();
        $alertmsg               = new \DictionaryAlertMsg();
        $alertmsg->body         = $content;
        $alertmsg->actionLocKey = "ActionLockey";
        $alertmsg->locKey       = "LocKey";
        $alertmsg->locArgs      = ["locargs"];
        $alertmsg->launchImage  = "launchimage";
        //IOS8.2 支持
        $alertmsg->title        = $title;
        $alertmsg->titleLocKey  = "TitleLocKey";
        $alertmsg->titleLocArgs = ["TitleLocArg"];
        //        $alertmsg->subtitle        = $title;
        //        $alertmsg->subtitleLocKey  = "subtitleLocKey";
        $alertmsg->subtitleLocArgs = ["subtitleLocArgs"];

        $apn->alertMsg = $alertmsg;
        //$apn->badge    = 2;
        $apn->sound = "";
        $apn->add_customMsg("payload", $payload);
        
        $apn->voicePlayType = 2;
        
        $apn->voicePlayMessage = "customize content";
        $apn->contentAvailable = 0;
        $apn->category         = "ACTIONABLE";
        //$apn->set_threadId("threadId");
        //        $sound_d = new \Sound();
        //        $sound_d->set_name("name");
        //        $sound_d->set_critical(1);
        //        $sound_d->set_volume(0.5);
        //        $apn->set_sound_d($sound_d);
        
        //        $media = new \IGtMultiMedia();
        //        $media->set_url("http://docs.getui.com/start/img/pushapp_android.png");
        //        $media->set_onlywifi(false);
        //        $media->set_type(MediaType::pic);
        //        $medias   = [];
        //        $medias[] = $media;
        //$apn->set_multiMedias($medias);
        $template->set_apnInfo($apn);
        
        $message = new \IGtSingleMessage();
        $message->set_isOffline(true);
        $message->set_offlineExpireTime(60 * 60 * 1000);
        $message->set_data($template);

        $target = new \IGtTarget();
        //appid
        $target->set_appId("g6WF9hW2cO7UsQDCqLOTfA");
        $target->set_clientId($cid);
        
        $result = $igt->pushMessageToSingle($message, $target);

        return $result;
    }


   
    public function IGtTransmissionTemplateGroup($url, $title, $content)
    {
        header("Content-Type: text/html; charset=utf-8");
        $root_path = $_SERVER['DOCUMENT_ROOT'] . $_SERVER['PHP_SELF'];
        $doc_path  = mb_substr($root_path, 0, mb_stripos($root_path, 'web/index.php'));

        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/IGt.Push.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/IGt.AppMessage.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/IGt.APNPayload.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/template/IGt.BaseTemplate.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/IGt.Batch.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/utils/AppConditions.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/template/notify/IGt.Notify.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/template/IGt.APNTemplate.php');
        require_once($doc_path . 'vendor/getuilaboratory/getui-pushapi-php-client/igetui/template/IGt.TransmissionTemplate.php');
        //Android
        $data            = [];
        $data['anzhuo']  = $this->anzhuoqun($url, $title, $content);
        //$data['pingguo'] = $this->pingguoqun($url, $title, $content);

        return $data;
    }


    public function anzhuoqun($url, $title, $content){
        //appkey and MasterSecret
        $igt      = new \IGeTui('http://sdk.open.api.igexin.com/apiex.htm', 'IVVmTXddVa6mvS1z5ZSPR6', 'xUs596G6PK9LYczebDe8E9');
        $template = new \IGtTransmissionTemplate();
        //appid
        $template->set_appId('g6WF9hW2cO7UsQDCqLOTfA');
        //appkey
        $template->set_appkey('IVVmTXddVa6mvS1z5ZSPR6');
        
        $payload    = '{"title":"' . $title . '","content":"' . $content . '","payload":"' . $url . '"}';
        $url_encode = urlencode($url);
        //android apk
        $anzhuobao='uni.UNI6324F5C';
        $intent     = 'intent:#Intent;action=android.intent.action.oppopush;launchFlags=0x14000000;component='.$anzhuobao.'/io.dcloud.PandoraEntry;S.UP-OL-SU=true;S.payload=' . $url_encode . ';end';

        $template->set_transmissionType(2);
        $template->set_transmissionContent($payload);
        $notify = new \IGtNotify();
        $notify->set_title($title);
        $notify->set_content($content);
        $notify->set_intent($intent);
        $notify->set_type(\NotifyInfo_type::_intent);

        $template->set3rdNotifyInfo($notify);

      
        $message = new \IGtAppMessage();
        $message->set_isOffline(true);
        $message->set_offlineExpireTime(720 * 3600 * 1000);
        $message->set_data($template);
        //appIdList     = [$cid];
        //appid
        $appIdList = ['g6WF9hW2cO7UsQDCqLOTfA'];
        $message->set_appIdList($appIdList);
        //$message->set_conditions($cdt->getCondition());
        
        $result = $igt->pushMessageToApp($message);

        return $result;
    }


    public function pingguoqun($url, $title, $content){
        $igt      = new \IGeTui('http://sdk.open.api.igexin.com/apiex.htm', 'NRDIhBJwTpA8wxnj5uhv44', 'UIkXFdyumT9LRWfTX0Th15');
        $template = new \IGtTransmissionTemplate();
        $template->set_appId('jsTJVKUwWy6n7X8IjXjNW2');
        //appkey
        $template->set_appkey('NRDIhBJwTpA8wxnj5uhv44');
      
        $payload    = '{"title":"' . $title . '","content":"' . $content . '","payload":"' . $url . '"}';
        $url_encode = urlencode($url);
        $intent     = 'intent:#Intent;action=android.intent.action.oppopush;launchFlags=0x14000000;component=uni.UNIBFC06D3/io.dcloud.PandoraEntry;S.UP-OL-SU=true;S.payload=' . $url_encode . ';end';

        $template->set_transmissionType(2);
        $template->set_transmissionContent($payload);
        //$template->set_duration(BEGINTIME,ENDTIME); 
        $template = new \IGtLinkTemplate();

        //$message = new \IGtSingleMessage();
        //  APN
        $apn                    = new \IGtAPNPayload();
        $alertmsg               = new \DictionaryAlertMsg();
        $alertmsg->body         = $content;
        $alertmsg->actionLocKey = "ActionLockey";
        $alertmsg->locKey       = "LocKey";
        $alertmsg->locArgs      = ["locargs"];
        $alertmsg->launchImage  = "launchimage";
        //IOS8.2
        $alertmsg->title        = $title;
        $alertmsg->titleLocKey  = "TitleLocKey";
        $alertmsg->titleLocArgs = ["TitleLocArg"];
        //        $alertmsg->subtitle        = $title;
        //        $alertmsg->subtitleLocKey  = "subtitleLocKey";
        $alertmsg->subtitleLocArgs = ["subtitleLocArgs"];

        $apn->alertMsg = $alertmsg;
        //$apn->badge    = 2;
        $apn->sound = "";
        $apn->add_customMsg("payload", $payload);
        
        $apn->voicePlayType = 2;
        
        $apn->voicePlayMessage = "定义内容";
        $apn->contentAvailable = 0;
        $apn->category         = "ACTIONABLE";

        //$apn->customMsg = array("payload"=>"payload");

        $template->set_apnInfo($apn);
        //da($template);


        
        $message = new \IGtAppMessage();
        $message->set_isOffline(true);
        $message->set_offlineExpireTime(2 * 3600 * 1000);
        $message->set_data($template);
        //$appIdList     = [$cid];
        $appIdList = ['jsTJVKUwWy6n7X8IjXjNW2'];
        $message->set_appIdList($appIdList);
        //da($message);
        //$message->set_conditions($cdt->getCondition());
        
        $result = $igt->pushMessageToApp($message);

        return $result;
    }


}