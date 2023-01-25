<?php

namespace app\components;

use yii\base\Component;
use AlibabaCloud\Client\AlibabaCloud;
use AlibabaCloud\Client\Exception\ClientException;
use AlibabaCloud\Client\Exception\ServerException;
use app\entities\Site;

class AliLiveAPI extends Component
{
    /**
     * AliLiveAPI constructor.
     */
    public function __construct()
    {
        //        $site       = Site::where('id', $this->site_id)->select('ali_appid','ali_secret','ali_regionid')->first();
        //        AlibabaCloud::accessKeyClient($site['ali_appid'], $site['ali_secret'])->regionId($site['ali_regionid'])->asDefaultClient();
    }


    /**
     * Get address
     *
     * @param $appName
     * @param $streamName
     *
     * @return array
     * @author lizhengfan
     * @time   2020/2/2 16:41
     */
    public function getPlayAddress($appName, $streamName)
    {
        $arrPlayAddress = [];

        //origin
        //lhd
        //lld
        //lsd
        //lud
        $origin = $this->createqunlityplayerurl($appName, $streamName, 'origin');
        $lhd    = $this->createqunlityplayerurl($appName, $streamName, 'lhd');
        $lld    = $this->createqunlityplayerurl($appName, $streamName, 'lld');
        $lsd    = $this->createqunlityplayerurl($appName, $streamName, 'lsd');
        $lud    = $this->createqunlityplayerurl($appName, $streamName, 'lud');

        $arrPlayAddress['origin'] = $origin;
        $arrPlayAddress['lhd']    = $lhd;
        $arrPlayAddress['lld']    = $lld;
        $arrPlayAddress['lsd']    = $lsd;
        $arrPlayAddress['lud']    = $lud;

        return $arrPlayAddress;
    }

    /**
     * Get Address
     *
     * @param $appName
     * @param $streamName
     * @param $quanlity
     *
     * @return array
     * @throws \Exception
     * @author lizhengfan
     * @time   2020/3/17 11:39
     */
    public function createqunlityplayerurl($appName, $streamName, $quanlity)
    {
        $key = \Yii::$app->params['ali.play.key'];
        $uri = \Yii::$app->params['ali.play.url'];
        $exp = time() + 60 * \Yii::$app->params['ali.timeout'];

        if ($quanlity != 'origin') {
            $streamName = $streamName . '_' . $quanlity;
        }
        $rtmppath = '/' . $appName . '/' . $streamName;
        $flvpath  = '/' . $appName . '/' . $streamName . '.flv';
        $m3u8path = '/' . $appName . '/' . $streamName . '.m3u8';

        $rtmpauthuri = $this->getauthkey($uri, $key, $exp, $rtmppath);
        $flvauthuri  = $this->getauthkey($uri, $key, $exp, $flvpath);
        $m3u8authuri = $this->getauthkey($uri, $key, $exp, $m3u8path);

        $arrPlayAddress = [];
        array_push($arrPlayAddress, $uri . $rtmpauthuri);
        array_push($arrPlayAddress, str_replace('rtmp', 'http', $uri) . $flvauthuri);
        array_push($arrPlayAddress, str_replace('rtmp', 'http', $uri) . $m3u8authuri);

        return $arrPlayAddress;
    }

    /**
     * Get streaming IP
     *
     * @param $appName
     * @param $streamName
     *
     * @return string
     * @author lizhengfan
     * @time   2020/2/2 16:42
     */
    public function getPushAddress($appName, $streamName)
    {
        $key  = \Yii::$app->params['ali.push.key'];
        $uri  = \Yii::$app->params['ali.push.url'];
        $exp  = time() + 60 * \Yii::$app->params['ali.timeout'];
        $path = '/' . $appName . '/' . $streamName;

        $authuri = $this->getauthkey($uri, $key, $exp, $path);

        return $uri . $authuri;
    }

    /**
     * Generate keys
     *
     * @param $uri
     * @param $key
     * @param $exp
     * @param $path
     *
     * @return string
     * @throws \Exception
     * @author lizhengfan
     * @time   2020/2/2 16:42
     */
    public function getauthkey($uri, $key, $exp, $path)
    {
        $rand      = random_int(10000, 99999);
        $uid       = 0;
        $sstring   = $path . '-' . $exp . '-' . $rand . '-' . $uid . '-' . $key;
        $hashvalue = md5($sstring);
        $authkey   = $exp . '-' . $rand . '-' . $uid . '-' . $hashvalue;

        return $path . '?auth_key=' . $authkey;
    }

    /**
     * Settings for VOD
     *
     * @author lizhengfan
     * @time   2020/3/26 16:57
     */
    public function configRecordToVod($appName)
    {
        $haveCOnfig = $this->getHaveConfigRecordToVod();
        $total      = $haveCOnfig['Total'];
        if ($total == 0) {
            try {
                $result = AlibabaCloud::rpc()
                    ->version(\Yii::$app->params['ali.api.version'])
                    ->action('AddLiveRecordVodConfig')
                    ->method(\Yii::$app->params['ali.request.method'])
                    ->host(\Yii::$app->params['ali.live.endpoint'])
                    ->options([
                        'query' => [
                            'AppName'                    => $appName,
                            'StreamName'                 => '*',
                            'CycleDuration'              => \Yii::$app->params['ali.vod.videoperiod'],
                            'DomainName'                 => \Yii::$app->params['ali.play.host'],
                            'VodTranscodeGroupId'        => \Yii::$app->params['ali.vod.vodtranscodegroupid'],
                            'AutoCompose'                => 'ON',
                            'ComposeVodTranscodeGroupId' => \Yii::$app->params['ali.vod.composevodtranscodegroupid'],
                        ],
                    ])
                    ->request();

                return $result;
            } catch (ClientException $e) {
                echo $e->getErrorMessage() . PHP_EOL;
            } catch (ServerException $e) {
                echo $e->getErrorMessage() . PHP_EOL;
            }
        }
    }

    /**
     * Checking if settings are available
     *
     * @return \AlibabaCloud\Client\Result\Result
     * @throws \AlibabaCloud\Client\Exception\ClientException
     * @throws \AlibabaCloud\Client\Exception\ServerException
     * @author lizhengfan
     * @time   2020/3/27 13:57
     */
    public function getHaveConfigRecordToVod()
    {
        try {
            $result = AlibabaCloud::rpc()
                ->version(\Yii::$app->params['ali.api.version'])
                ->action('DescribeLiveRecordVodConfigs')
                ->method(\Yii::$app->params['ali.request.method'])
                ->host(\Yii::$app->params['ali.live.endpoint'])
                ->options([
                    'query' => [
                        'DomainName' => \Yii::$app->params['ali.play.host'],
                    ],
                ])
                ->request();

            return $result->toArray();
        } catch (ClientException $e) {
            echo $e->getErrorMessage() . PHP_EOL;
        } catch (ServerException $e) {
            echo $e->getErrorMessage() . PHP_EOL;
        }
    }

    /**
     * Get playback list
     *
     * @return Response
     * @throws \AlibabaCloud\Client\Exception\ClientException
     * @throws \AlibabaCloud\Client\Exception\ServerException
     * @author lizhengfan
     * @time   2020/3/25 8:42
     */
    public function getLiverecordlist($roomid, $time)
    {
        $appName    = \Yii::$app->params['live.appname'];
        $streamName = 'liveroom' . $roomid;


        if (empty($time)) {
            $endTime = time();
        } else {
            $endTime = strtotime($time);
        }
        $startTime = $endTime - \Yii::$app->params['ali.timeout'] * 60;

        $endTime   = subStr(gmdate("c", $endTime), 0, 19) . "Z";
        $startTime = subStr(gmdate("c", $startTime), 0, 19) . "Z";


        $totalDuration = 0;
        try {
            $result = AlibabaCloud::rpc()
                ->version(\Yii::$app->params['ali.api.version'])
                ->action('DescribeLiveStreamRecordIndexFiles')
                ->method(\Yii::$app->params['ali.request.method'])
                ->host(\Yii::$app->params['ali.live.endpoint'])
                ->options([
                    'query' => [
                        'AppName'    => $appName,
                        'DomainName' => \Yii::$app->params['ali.play.host'],
                        'StreamName' => $streamName,
                        'StartTime'  => $startTime,
                        'EndTime'    => $endTime,
                    ],
                ])
                ->request();

            $arrRecordinfo = $result->RecordIndexInfoList->RecordIndexInfo;

            $arrRecordIndexInfo = [];
            foreach ($arrRecordinfo as $key => $item) {
                $EndTime = $item->EndTime;
                $EndTime = strtotime($EndTime);
                $EndTime = date('Y-m-d H:i:s', $EndTime);

                $StartTime = $item->StartTime;
                $StartTime = strtotime($StartTime);
                $StartTime = date('Y-m-d H:i:s', $StartTime);

                $CreateTime = $item->CreateTime;
                $CreateTime = strtotime($CreateTime);
                $CreateTime = date('Y-m-d H:i:s', $CreateTime);

                $RecordIndexInfo['EndTime']    = $EndTime;
                $RecordIndexInfo['CreateTime'] = $CreateTime;
                $RecordIndexInfo['StartTime']  = $StartTime;
                $RecordIndexInfo['Duration']   = $item->Duration;
                $RecordIndexInfo['AppName']    = $item->AppName;
                $RecordIndexInfo['StreamName'] = $item->StreamName;
                $RecordIndexInfo['RecordUrl']  = $item->RecordUrl;
                $RecordIndexInfo['Height']     = $item->Height;
                $RecordIndexInfo['Width']      = $item->Width;

                $totalDuration += $item->Duration;

                array_push($arrRecordIndexInfo, $RecordIndexInfo);
            }

            $data['totalDuration']     = $totalDuration;
            $data['arrLiveRecordList'] = $arrRecordIndexInfo;

            return $data;
        } catch (ClientException $e) {
            echo $e->getErrorMessage() . PHP_EOL;
        } catch (ServerException $e) {
            echo $e->getErrorMessage() . PHP_EOL;
        }
    }


    public function nowlive($domainname, $appName, $streamName)
    {
        $result = AlibabaCloud::rpc()->version('2014-11-11')->product('Cdn')->action('DescribeLiveStreamsOnlineList')->method('GET')->withAppName($appName)->withStreamName($streamName)->withDomainName($domainname)->request();

        return $result->toArray();
    }

    //Get streamname
    public function nowliveing($domainname, $ali_appid, $ali_secret, $ali_regionid)
    {
        //$site       = Site::where('id', $this->site_id)->select('ali_appid','ali_secret','ali_regionid')->first();
        AlibabaCloud::accessKeyClient($ali_appid, $ali_secret)->regionId($ali_regionid)->asDefaultClient();
        $result = AlibabaCloud::rpc()->version('2014-11-11')->product('Cdn')->action('DescribeLiveStreamsOnlineList')->withDomainName($domainname)->method('GET')->request();
        $data   = $result->toArray();
        if (!empty($data['OnlineInfo']['LiveStreamOnlineInfo'])) {
            $arr = [];
            foreach ($data['OnlineInfo']['LiveStreamOnlineInfo'] as $k => $v) {
                $arr[] = $v['StreamName'];
            }
        } else {
            $arr = [];
        }

        return $arr;
    }

    //Video Transcode
    public function videochange($domainname, $ali_appid, $ali_secret, $ali_regionid,$appname)
    {
        // Original SDK Code
        //$site       = Site::where('id', $this->site_id)->select('ali_appid','ali_secret','ali_regionid')->first();
        // AlibabaCloud::accessKeyClient($ali_appid, $ali_secret)->regionId($ali_regionid)->asDefaultClient();
        // $result = AlibabaCloud::rpc()->version('2014-11-11')->product('Cdn')->action('AddLiveStreamTranscode')->withDomain($domainname)->withTemplate('*')->withRecord('*')->withSnapshot('*')->withApp($appname)->method('GET')->request();
        // $data   = $result->toArray();
        // return $data;
        // 新
        AlibabaCloud::accessKeyClient($ali_appid, $ali_secret)
                        ->regionId('cn-hangzhou')
                        ->asDefaultClient();

        try {
            $result = AlibabaCloud::rpc()
                                  ->product('live')
                                  // ->scheme('https') // https | http
                                  ->version('2016-11-01')
                                  ->action('AddLiveStreamTranscode')
                                  ->method('POST')
                                  ->host('live.aliyuncs.com')
                                  ->options([
                                                'query' => [
                                                  'RegionId' => "cn-hangzhou",
                                                  'App' => $appname,
                                                  'Template' => "lud",
                                                  'Domain' => $domainname,
                                                ],
                                            ])
                                  ->request();
            return $result->toArray();
            // da($result->toArray());
        } catch (ClientException $e) {
            echo $e->getErrorMessage() . PHP_EOL;
        } catch (ServerException $e) {
            echo $e->getErrorMessage() . PHP_EOL;
        }
    }

    //Getstreamname and live stream timing
    public function nowliveingandtime($domainname)
    {
        $result = AlibabaCloud::rpc()->version('2014-11-11')->product('Cdn')->action('DescribeLiveStreamsOnlineList')->withDomainName($domainname)->method('GET')->request();
        $data   = $result->toArray();
        if (!empty($data['OnlineInfo']['LiveStreamOnlineInfo'])) {
            $arr = [];
            foreach ($data['OnlineInfo']['LiveStreamOnlineInfo'] as $k => $v) {
                $arr1                = [];
                $arr1['streamname']  = $v['StreamName'];
                $arr1['publishtime'] = date("Y-m-d H:i:s", strtotime($v['PublishTime']));
                $arr[]               = $arr1;
            }
        } else {
            $arr = [];
        }

        return $arr;
    }

    
    public function nowlives($domainname, $appName, $streamName)
    {
        $starttime = '2020-05-15T02:46:12Z';
        $starttime = strtotime($starttime);
        $now_time  = time();
        //$starttime=date('Y-m-d H:i:s', $now_time-30);
        //$starttime=date('Y-m-d\TH:i:s\Z', $now_time-60);
        da($starttime);
        $endtime = date('Y-m-d\TH:i:s\Z', $now_time + 60);
        $result  = AlibabaCloud::rpc()->version('2014-11-11')->product('Cdn')->action('DescribeLiveStreamsPublishList')->method('GET')->withAppName($appName)->withStreamName($streamName)->withDomainName($domainname)->withStartTime($starttime)->withEndTime($endtime)->request();

        return $result->toArray();
    }


}