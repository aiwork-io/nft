<?php

namespace app\components;

use app\entities\Site;
use yii\base\Component;
use yii\log\Logger;

class PaymentService extends Component
{

    //Alipay2.0--H5payment
    static public function zhifubaohfive($arr, $subject, $out_trade_no, $time_out, $total_amount, $passback_params, $url)
    {
        require_once '../vendor/alipay.trade.wap.pay-PHP-UTF-8/aop/AopClient.php';
        require_once '../vendor/alipay.trade.wap.pay-PHP-UTF-8/aop/request/AlipayTradeWapPayRequest.php';
        $aop = new \AopClient();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = trim($arr['zfb_app_id']);
        $aop->rsaPrivateKey = trim($arr['zfb_rsaprivatekey']);
        $aop->alipayrsaPublicKey=trim($arr['zfb_alipayrsapublickey']);
        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset='UTF-8';
        $aop->format='json';
        $object = new \stdClass();
        $object->out_trade_no = $out_trade_no;
        $object->total_amount = $total_amount;
        $object->body = $arr['id'];
        $object->subject = $subject;
        $object->product_code ='QUICK_WAP_WAY';
        $object->time_expire = $time_out;
        $passback_params = UrlEncode($passback_params);
        $object->passback_params = $passback_params;
        $json = json_encode($object);
        $request = new \AlipayTradeWapPayRequest();
        $request->setNotifyUrl($url);
        //$request->setReturnUrl('');
        $request->setBizContent($json);
        $result = $aop->pageExecute($request,'get'); 
        return $result;
        // $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        // $resultCode = $result->$responseNode->code;
        // if(!empty($resultCode)&&$resultCode == 10000){
        // echo "success";
        // } else {
        // echo "failure";
        // }

    }

    //Alipay.0--refund
    static public function zhifubaotuikuanhfive($arr,$out_trade_no_have_pay, $out_trade_no, $total_amount)
    {
        require_once '../vendor/alipay.trade.wap.pay-PHP-UTF-8/aop/AopClient.php';
        require_once '../vendor/alipay.trade.wap.pay-PHP-UTF-8/aop/request/AlipayTradeRefundRequest.php';
        require_once '../vendor/alipay.trade.wap.pay-PHP-UTF-8/aop/SignData.php';
        $aop = new \AopClient ();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = trim($arr['zfb_app_id']);
        $aop->rsaPrivateKey = trim($arr['zfb_rsaprivatekey']);
        $aop->alipayrsaPublicKey=trim($arr['zfb_alipayrsapublickey']);
        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset="UTF-8";
        $aop->format='json';
        $object = new \stdClass();
        $object->out_trade_no = $out_trade_no_have_pay;
        $object->refund_amount = $total_amount;
        $object->out_request_no = $out_trade_no;
        $json = json_encode($object);
        $request = new \AlipayTradeRefundRequest();
        $request->setBizContent($json);
        $result = $aop->execute($request); 

        $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        $resultCode = $result->$responseNode;
        
        return $resultCode;
    }


    //Original Alipay
    static public function zhifubaoyuansheng($body, $subject, $out_trade_no, $time_out, $total_amount, $passback_params, $url)
    {
        $site = Site::select('zfb_app_id', 'zfb_rsaprivatekey', 'zfb_alipayrsapublickey')->first();
        require_once '../vendor/alipay-sdk-PHP/aop/AopClient.php';
        require_once '../vendor/alipay-sdk-PHP/aop/request/AlipayTradeAppPayRequest.php';
        $aop                     = new \AopClient();
        $aop->gatewayUrl         = 'https://openapi.alipay.com/gateway.do';
        $aop->appId              = trim($site['zfb_app_id']);
        $aop->rsaPrivateKey      = trim($site['zfb_rsaprivatekey']);
        $aop->format             = "json";
        $aop->postCharset        = "UTF-8";
        $aop->signType           = "RSA2";
        $aop->alipayrsaPublicKey = trim($site['zfb_alipayrsapublickey']);
        $request = new \AlipayTradeAppPayRequest();
        //public parameters have been pre-set in SDK
        $passback_params = UrlEncode($passback_params);
        $bizcontent      = "{\"body\":\"$body\","
            . "\"subject\": \"$subject\","
            . "\"out_trade_no\": \"$out_trade_no\","
            . "\"timeout_express\": \"$time_out\","
            . "\"total_amount\": \"$total_amount\","
            . "\"passback_params\":\"$passback_params\""
            . "}";
        $request->setNotifyUrl($url);
        $request->setBizContent($bizcontent);
        $response = $aop->sdkExecute($request);

        return $response;
    }

    //Alipay refund
    static public function zhifubaotuikuan($out_trade_no_have_pay, $out_trade_no, $total_amount)
    {
        $site = Site::select('zfb_app_id', 'zfb_rsaprivatekey', 'zfb_alipayrsapublickey')->first();
        require_once '../vendor/alipay-sdk-PHP/aop/AopClient.php';
        require_once '../vendor/alipay-sdk-PHP/aop/request/AlipayTradeRefundRequest.php';
        $aop                     = new \AopClient ();
        $aop->gatewayUrl         = 'https://openapi.alipay.com/gateway.do';
        $aop->appId              = trim($site['zfb_app_id']);
        $aop->rsaPrivateKey      = trim($site['zfb_rsaprivatekey']);
        $aop->alipayrsaPublicKey = trim($site['zfb_alipayrsapublickey']);
        $aop->apiVersion         = '1.0';
        $aop->signType           = 'RSA2';
        $aop->postCharset        = "UTF-8";
        $aop->format             = 'json';
        $request                 = new \AlipayTradeRefundRequest();

        $request->setBizContent("{" .
            "\"out_trade_no\":\"$out_trade_no_have_pay\"," .
            "\"out_request_no\":\"$out_trade_no\"," .
            "\"refund_amount\":$total_amount" .
            //            "\"refund_reason\":\"$reason\"," .
            //            "\"goods_id\":\"$goods_id\"," .
            //            "\"goods_name\":\"$goods_name\"" .
            //            "\"quantity\":1," .
            //            "\"price\":$goods_price," .
            //            "\"trans_in_type\":\"loginName\"," .
            //            "\"trans_in\":\"18949853229\"," .
            //            "\"operator_id\":\"OP001\"," .
            //            "\"store_id\":\"NJ_S_001\"," .
            //            "\"terminal_id\":\"NJ_T_001\"" .
            "  }");
        $result = $aop->execute($request);
        //\Yii::getLogger()->log($result, Logger::LEVEL_ERROR);
        //da($result);
        $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        $resultCode   = $result->$responseNode;

        return $resultCode;
    }


}