<?php

namespace app\components;

use app\entities\Bondorder;
use app\entities\GoodsOrder;
use app\entities\Wallet;
use app\entities\WalletList;
use Carbon\Carbon;
use Illuminate\Database\Capsule\Manager as DB;
use yii\base\Component;
use EasyWeChat\Factory;
use yii\log\Logger;

class OrderPay extends Component
{
    
    public static function payorder($config = [], $q = 'wx', $openid = '', $serial_number = '', $body = '', $amount = '1', $notify_url = '', $remark = '')
    {
        //Test amount
        //$amount=0.01;
        //mini payment app
        if ($q == 'wx') {
            $options = [
                'app_id' => $config['mini_appid'],
                'mch_id' => $config['merchantid'],
                'key'    => $config['keys'],
            ];
        } else if ($q == 'h5' || $q == 'wap') {
            //h5
            $options = [
                'app_id' => $config['appid'],
                'mch_id' => $config['merchantid'],
                'key'    => $config['keys'],
            ];
        } else {
            //app
            $options = [
                // 'app_id' => $config['kfpt_appid'],
                'app_id' => 'wx48412aa7635cf1e4',
                'mch_id' => $config['merchantid'],
                'key'    => $config['keys'],
            ];
        }
        $pay_app = Factory::payment($options);
        $total   = [];

        if ($q == 'wx' || $q == 'h5') {
            //mini app
            $result = $pay_app->order->unify([
                'body'         => $body,
                'out_trade_no' => $serial_number,
                'total_fee'    => $amount * 100, 
                //'total_fee'    => 1, 
                'notify_url'   => $notify_url,
                'trade_type'   => 'JSAPI',
                'openid'       => $openid,
            ]);
            \Yii::getLogger()->log($remark . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);

            if ($result['return_code'] == 'SUCCESS' && $result['result_code'] == 'SUCCESS') {
                $prepayId = $result['prepay_id'];
                //generate JS settings
                $jssdk                = $pay_app->jssdk;
                $pay_info             = json_decode($jssdk->bridgeConfig($prepayId), true);
                $total['return_code'] = 'SUCCESS';
                $total['result_code'] = 'SUCCESS';
                $total['pay_info']    = $pay_info;
            } else {
                $total['return_code']  = 'FAIL';
                $total['result_code']  = 'FAIL';
                $total['err_code_des'] = $result['err_code_des'];
            }

        } elseif ($q == 'wap') {
            //H5 payment
            $result = $pay_app->order->unify([
                'body'         => $body,
                'out_trade_no' => $serial_number,
                'total_fee'    => $amount * 100, // unit
                //'total_fee'    => 1, // unit
                'notify_url'   => $notify_url,
                'trade_type'   => 'MWEB',//
            ]);
            \Yii::getLogger()->log($remark . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);

            if ($result['return_code'] == 'SUCCESS' && $result['result_code'] == 'SUCCESS') {
                $total['return_code'] = 'SUCCESS';
                $total['result_code'] = 'SUCCESS';
                $total['pay_info']    = $result['mweb_url'];
            } else {
                $total                 = [];
                $total['return_code']  = 'FAIL';
                $total['result_code']  = 'FAIL';
                $total['err_code_des'] = $result['err_code_des'];
            }

        } else {
            //App payment
            $result = $pay_app->order->unify([
                'body'         => $body,
                'out_trade_no' => $serial_number,
                'total_fee'    => $amount * 100, // 
                //'total_fee'    => 1, // 
                'notify_url'   => $notify_url,
                'trade_type'   => 'APP',
            ]);
            \Yii::getLogger()->log($remark . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);

            if ($result['return_code'] == 'SUCCESS' && $result['result_code'] == 'SUCCESS') {
                //generate JS setting
                $prepayId = $result['prepay_id'];
                //generate payment JS setting
                $pay_info             = $pay_app->jssdk->appConfig($prepayId);
                $total['return_code'] = 'SUCCESS';
                $total['result_code'] = 'SUCCESS';
                $total['pay_info']    = $pay_info;
            } else {
                $total['return_code']  = 'FAIL';
                $total['result_code']  = 'FAIL';
                $total['err_code_des'] = $result['err_code_des'];
            }

        }

        return $total;


    }

    //refund deposit
    public static function refund($config = [], $doc_path = '', $user_id = '', $goods_id = '', $sid = '', $type = '1')
    {
        //type1 deposit refund 
        if ($type == 1) {
            $bondmoney = Bondorder::where(['user_id'=>$user_id,'goods_id'=>$goods_id,'sid'=>$sid,'status'=>1])->first();
        }else{
            //goods_id here is order_id
            $bondmoney = GoodsOrder::where(['user_id'=>$user_id,'id'=>$goods_id,'site_id'=>$sid])->first();
        }
        if(empty($bondmoney)){
            $total                = [];
            $total['return_code'] = 'SUCCESS';
            $total['result_code'] = 'SUCCESS';
            return $total;
        }
        $zf_type=$bondmoney['zf_type'];
        if($zf_type=='wx'){
            $payment_options = [
                'app_id'    => $config['appid'],
                'mch_id'    => $config['merchantid'],
                'key'       => $config['keys'],
                'cert_path' => $doc_path . $config['certificate_one'],
                'key_path'  => $doc_path . $config['certificate_two'],
            ];
        }else if($zf_type=='xcx'){
            $payment_options = [
                'app_id'    => $config['mini_appid'],
                'mch_id'    => $config['merchantid'],
                'key'       => $config['keys'],
                'cert_path' => $doc_path . $config['certificate_one'],
                'key_path'  => $doc_path . $config['certificate_two'],
            ];
        }else if($zf_type=='app'){
            $payment_options = [
                'app_id'    => $config['mini_appid'],
                'mch_id'    => $config['merchantid'],
                'key'       => $config['keys'],
                'cert_path' => $doc_path . $config['certificate_one'],
                'key_path'  => $doc_path . $config['certificate_two'],
            ];
        }else if($zf_type=='zfb' || $zf_type=='yue'){
            $payment_options = [];
        }else{
            $payment_options = [
                'app_id'    => $config['appid'] ?: $config['mini_appid'],
                'mch_id'    => $config['merchantid'],
                'key'       => $config['keys'],
                'cert_path' => $doc_path . $config['certificate_one'],
                'key_path'  => $doc_path . $config['certificate_two'],
            ];
        }
        //payment refund, random ID
        $serial_number=$user_id.$goods_id.time();
        if ($type == 1) {
            //If payment done through alipay
            if ($bondmoney['zf_type'] == 'zfb') {
                //alipay old edition
                //$result = PaymentService::zhifubaotuikuan($bondmoney['serial_number'], $serial_number, $bondmoney['bond_price']);
                $result = PaymentService::zhifubaotuikuanhfive($config,$bondmoney['serial_number'],$serial_number,$bondmoney['bond_price']);
                if($result->code == '10000') {
                    $bondmoney->status        = 2;
                    $bondmoney->refund_number = $serial_number;
                    $bondmoney->bond_price    = $result->refund_fee;
                    $bondmoney->refundtime    = time();
                    $bondmoney->save();
                    $total                = [];
                    $total['return_code'] = 'SUCCESS';
                    $total['result_code'] = 'SUCCESS';
                    return $total;
                }else{
                    $total                = [];
                    $total['return_code'] = 'FAIL';
                    $total['result_code'] = 'FAIL';
                    $total['return_msg']  = 'Refund unsuccessful, please contact platform 1';
                    return $total;
                }
            }else if($bondmoney['zf_type'] == 'yue' ){
                DB::beginTransaction();
                try {
                    //get user wallet
                    $wallet = Wallet::where(['user_id' => $user_id, 'site_id' => $sid])->lockForUpdate()->first();
                    $order_price = $bondmoney['bond_price'];
                    //update user wallet status
                    $wallet->total_in = bcadd($wallet->total_in, $order_price, 2);
                    $wallet->save();
                    //add transaction record
                    $wallet_list                  = new WalletList();
                    $wallet_list->user_id         = $user_id;
                    $wallet_list->order_id        = $bondmoney->id;
                    $wallet_list->info            = 'Deposit refund amount';
                    $wallet_list->brief           = "Deposit refund amount";
                    $wallet_list->type            = 2;
                    $wallet_list->amount          = $order_price;
                    $wallet_list->status          = 1;
                    $wallet_list->site_id         = $sid;
                    $wallet_list->zf_type         = 'yue';
                    $wallet_list->buyer_or_seller = 1;
                    $wallet_list->save();

                    
                    $time              = time();
                    $bondmoney->refundtime    = $time;
                    $bondmoney->status     = 2;
                    $bondmoney->bond_price = $order_price;
                    $bondmoney->save();
                
                    DB::commit();
                    
                    $total                = [];
                    $total['return_code'] = 'SUCCESS';
                    $total['result_code'] = 'SUCCESS';
                    return $total;
                } catch (\Exception $e) {
                    DB::rollBack();
                    \Yii::getLogger()->log('用户:' . $user_id . 'Refund unsuccessful:' . $goods_id . 'error:' . $e, Logger::LEVEL_ERROR);

                    $total                = [];
                    $total['return_code'] = 'FAIL';
                    $total['result_code'] = 'FAIL';
                    $total['return_msg']  = 'Refund unsuccessful, please contact platform 1';

                    return $total;
                }
            }else {
                $pay_app     = Factory::payment($payment_options);
                $time        = time();
                $total_price = $bondmoney['bond_price'] * 100;
                $price       = $bondmoney['price'] * 100;
                $result      = $pay_app->refund->byOutTradeNumber($bondmoney['serial_number'], $time, $total_price, $price, ['refund_desc' => 'Refund deposit']);
                \Yii::getLogger()->log('Refund user after successful order' . $user_id . 'product' . $goods_id . 'Deposit result' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
                if ($result['return_code'] == 'SUCCESS' && $result['result_code'] == 'SUCCESS') {
                    $bondmoney->refund_number = $result['refund_id'];
                    $bondmoney->status        = 2;
                    $bondmoney->refundtime    = $time;
                    $bondmoney->save();
                    $total                = [];
                    $total['return_code'] = 'SUCCESS';
                    $total['result_code'] = 'SUCCESS';

                    return $total;
                } else {
                    $total                = [];
                    $total['return_code'] = 'FAIL';
                    $total['result_code'] = 'FAIL';
                    $total['return_msg']  = 'Refund unsuccessful, please contact platform 1';

                    return $total;
                }
            }
            
        } else {
            $time        = time();
            if ($bondmoney['zf_type'] == 'zfb') {
                //old payment workflow
                //$result = PaymentService::zhifubaotuikuan($bondmoney['serial_number'], $serial_number, $bondmoney['bond_price']);
                $result = PaymentService::zhifubaotuikuanhfive($config,$bondmoney['serial_number'],$serial_number,$bondmoney['auctioner_price']);
                if($result->code == '10000') {
                    $bondmoney->refundtime = $time;
                    $bondmoney->save();
                    $total                = [];
                    $total['return_code'] = 'SUCCESS';
                    $total['result_code'] = 'SUCCESS';

                    return $total;
                }else{
                    $total                = [];
                    $total['return_code'] = 'FAIL';
                    $total['result_code'] = 'FAIL';
                    $total['return_msg']  = 'Refund unsuccessful, please contact platform 1';
                    return $total;
                }
            }else{
                $pay_app     = Factory::payment($payment_options);
                $total_price = $bondmoney['auctioner_price'] * 100;
                $price       = $bondmoney['auctioner_price'] * 100;
                $result      = $pay_app->refund->byOutTradeNumber($bondmoney['serial_number'], $time, $total_price, $price, ['refund_desc' => 'refund']);
                \Yii::getLogger()->log('processing order' . $goods_id . 'wechat refund result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
                if ($result['return_code'] == 'SUCCESS' && $result['result_code'] == 'SUCCESS') {
                    $bondmoney->refundtime = $time;
                    $bondmoney->save();
                    $total                = [];
                    $total['return_code'] = 'SUCCESS';
                    $total['result_code'] = 'SUCCESS';

                    return $total;
                } else {
                    $total                = [];
                    $total['return_code'] = 'FAIL';
                    $total['result_code'] = 'FAIL';
                    $total['return_msg']  = $result['return_msg'];

                    return $total;
                }
            }


        }


    }


}
