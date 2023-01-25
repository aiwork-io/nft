<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/8/1
 * Time: 3:20
 */

namespace app\components;

use app\entities\Site;
use Yii;
use yii\web\UrlRuleInterface;
use yii\base\BaseObject;

class WechatUrlRule extends BaseObject implements UrlRuleInterface
{

    public function createUrl($manager, $route, $params)
    {
        return false;
    }

    public function parseRequest($manager, $request)
    {
        $site     = Site::where('appid', '!=', null)->where('appsecret', '!=', null)->where('uniacid', '!=', null)->first();
        $pathInfo = $request->getPathInfo();
        if ($pathInfo === 'wechat-pay-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/offer-price/wechat-pay-notify', $params];
        } else if ($pathInfo === 'wechat-pay-goods-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/orders/wechat-pay-goods-notify', $params];
        } else if ($pathInfo === 'wechat-pay-recharge-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/orders/wechat-pay-recharge-notify', $params];
        } else if ($pathInfo === 'wechat-pay-premium-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/orders/wechat-pay-premium-notify', $params];
        } else if ($pathInfo === 'wechat-pay-diamonds-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/orders/wechat-pay-diamonds-notify', $params];
        } else if ($pathInfo === 'pay-activity-order-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/orders/pay-activity-order-notify', $params];
        } else if ($pathInfo === 'pay-assemble-order-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/orders/pay-assemble-order-notify', $params];
        } else if ($pathInfo === 'pay-zb-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['home/live/pay-zb-notify', $params];
           
        } else if ($pathInfo === 'paythreeto') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/orders/paythreeto', $params];
            //api top up
        } else if ($pathInfo === 'apicz') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/orders/apicz', $params];
            //api payment
        } else if ($pathInfo === 'apizfdd') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/orders/apizfdd', $params];
            
        } else if ($pathInfo === 'apizfddjd') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/orders/apizfddjd', $params];
           
        } else if ($pathInfo === 'apizfxbj') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/orders/apizfxbj', $params];
            
        } else if ($pathInfo === 'apisjdp') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/orders/apisjdp', $params];
            
        } else if ($pathInfo === 'apizfbzj') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/offer-price/apizfbzj', $params];
            
        } else if ($pathInfo === 'apizb') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/live/apizb', $params];
        } else if ($pathInfo === 'jfzfdd') {
            $params['return']  = true;
            $params['sid']     = $site['id'];
            $params['uniacid'] = $site['uniacid'];

            return ['api/orders/jfzfdd', $params];
        } else if ($pathInfo === 'apiwxad') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['api/advert/apiwxad', $params];
          
        } else if ($pathInfo == 'z-pay-recharge-notify') {
            $params['return'] = true;
            $params['sid']    = $site['id'];

            return ['api/orders/z-pay-recharge-notify', $params];
        } else {
            $route = $request->getQueryParam('r', '');
            if (is_array($route)) {
                $route = '';
            }

            return [(string)$route, []];
        }

    }

}
