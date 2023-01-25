<?php

namespace app\components;

use app\entities\Template;
use app\entities\User;
use app\entities\UserLevel;
use yii\base\Component;
use app\entities\KeyWordReplace;
use EasyWeChat\Factory;
use yii\log\Logger;

class Comdata extends Component
{
    //Order
    public static function fahuo($config = [], $oid = '', $mid = '', $order_number = '', $buy_name = '', $express_name = '', $express_code = '', $goods_name = '')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config['uniacid'] . '#/';
        $path        = 'pagesA/order/userOrder/userOrder?s=2';
        $template    = Template::firstOrCreate(['site_id' => $config->id]);
        //Public account notification
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_fahuo'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_fahuo']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hello，your【' . $config['name'] . '】order has been processed',
                            ],
                        'keyword1' =>
                            [
                                'value' => date('Y-m-d H:i:s', time()),

                            ],
                        'keyword2' =>
                            [
                                'value' => $buy_name,
                            ],
                        'keyword3' =>
                            [
                                'value' => $order_number,
                            ],
                        'keyword4' =>
                            [
                                'value' => $express_name,
                            ],
                        'keyword5' =>
                            [
                                'value' => $express_code,
                            ],
                        'remark'   => [
                            'value' => 'please checked details',
                            'color' => '#898989',
                        ],

                    ],
            ]);
            \Yii::getLogger()->log('Order ID:' . $order_number . 'Delivery Message Result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_fahuo'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_fahuo']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'            => [
                        'value' => $goods_name,
                    ],
                    'character_string2' => [
                        'value' => $order_number,
                    ],
                    'date3'             => [
                        'value' => date("Y-m-d H:i:s", time()),
                    ],
                    'thing4'            => [
                        'value' => $express_name,
                    ],
                    'character_string5' => [
                        'value' => $express_code,
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Order ID:' . $order_number . 'Delivery order app status:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;

    }

   
    public static function chujiachaoyue($config = [], $oid = '', $mid = '', $last_user_price = '', $goods_id = '', $goods_name = '', $now_max_price = '',$is_zc='')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        if($is_zc==1){
            $path = 'pagesB/special/specialGoods/specialGoods?id=' . $goods_id;
        }else{
            $path = 'pagesA/goods/detail?id=' . $goods_id;
        }

        $name        = KeyWordReplace::where(['site_id' => $config['id'], 'xid' => 1])->first()->name;
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

        //公众号通知
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_chujia'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_chujia']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'  =>
                            [
                                'value' => '感谢您参与' . $name . '，您的出价【' . $last_user_price . '】已被超越。',
                                'color' => '#173177',
                            ],
                        'number' =>
                            [
                                'value' => $goods_id,
                                'color' => '#FF0000',
                            ],
                        'name'   =>
                            [
                                'value' => $goods_name,
                                'color' => '#173177',
                            ],
                        'remark' =>
                            [
                                'value' => '请立即前往查看',
                                'color' => 'blue',
                            ],
                    ],
            ]);
            \Yii::getLogger()->log('product id:' . $goods_id . 'Price Result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        //小程序消息
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_chujia'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_chujia']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'  => [
                        'value' => $goods_name,
                    ],
                    'amount2' => [
                        'value' => $now_max_price,
                    ],
                    'thing4'  => [
                        'value' => 'Your price has been surpassed',
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Product id:' . $goods_id . 'Price Result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

    //Pending Payment Notification
    public static function dingdanweizhifu($config = [], $oid = '', $mid = '', $order_number = '', $price = '', $goods_name = '', $cut_off_time = '')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesA/order/userOrder/userOrder?s=0';
        $name        = KeyWordReplace::where(['site_id' => $config['id'], 'xid' => 1])->first()->name;
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

        //公众号通知
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_order'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_order']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hello，your order from【' . $config['name'] . '】is successful. 【' . $name . $goods_name . '】order has been generated',
                                'color' => '#173177',
                            ],
                        'keyword1' =>
                            [
                                'value' => $order_number,

                            ],
                        'keyword2' =>
                            [
                                'value' => $price . "$",
                            ],
                        'remark'   =>
                            [
                                'value' => 'pending payment',
                                'color' => 'blue',
                            ],
                    ],
            ]);
            \Yii::getLogger()->log('Product ID:' . $order_number . 'Order result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        //app news
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_order'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_order']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'character_string1' => [
                        'value' => $order_number,
                    ],
                    'thing2'            => [
                        'value' => 'Hello，【' . $config['name'] . '】has a new pending order',
                    ],
                    'amount3'           => [
                        'value' => $price,
                    ],
                    'date4'             => [
                        'value' => $cut_off_time,
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Product ID:' . $order_number . 'Order Result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

    
    public static function daifahuo($config = [], $oid = '', $mid = '', $buy_name = '', $order_number = '', $order_price = '', $goods_title = '')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesA/order/sellerOrder/sellerOrder?s=1';
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

        //公众号通知
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_daifahuo'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_daifahuo']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hello【' . $config['name'] . '】has a new order',
                                'color' => '#173177',
                            ],
                        'keyword1' =>
                            [
                                'value' => $order_number,
                            ],
                        'keyword2' =>
                            [
                                'value' => $order_price,
                            ],
                        'keyword3' =>
                            [
                                'value' => $buy_name,
                            ],
                        'keyword4' =>
                            [
                                'value' => '已支付',
                            ],
                        'remark'   =>
                            [
                                'value' => 'customer has paid, please deliver the goods',
                            ],

                    ],
            ]);
            \Yii::getLogger()->log('Product ID:' . $order_number . 'Order Result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_daifahuo'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_daifahuo']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'            => [
                        'value' => $goods_title,
                    ],
                    'character_string2' => [
                        'value' => $order_number,
                    ],
                    'amount3'           => [
                        'value' => $order_price,
                    ],
                    'date4'             => [
                        'value' => date("Y-m-d H:i:s", time()),
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('商品订单号:' . $order_number . '订单待发货生成模板消息小程序发送结果:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

    
    public static function shouhuo($config = [], $oid = '', $mid = '', $buy_name = '', $order_number = '', $goods_name = '')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesA/order/sellerOrder/sellerOrder?s=3';
        $name        = KeyWordReplace::where(['site_id' => $config['id'], 'xid' => 1])->first()->name;
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

       
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_shouhuo'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_shouhuo']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hellow，The buyer【' . $buy_name . '】@【' . $config['name'] . '】has gotten' . $name . '【' . $goods_name . '】the order has been confirmed',
                                'color' => '#173177',
                            ],
                        'keyword1' =>
                            [
                                'value' => $goods_name,
                            ],
                        'keyword2' =>
                            [
                                'value' => $order_number,
                            ],

                    ],
            ]);
            \Yii::getLogger()->log('Product ID:' . $order_number . 'Order Confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_shouhuo'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_shouhuo']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'            => [
                        'value' => $goods_name,
                    ],
                    'character_string2' => [
                        'value' => $order_number,
                    ],
                    'date3'             => [
                        'value' => date("Y-m-d H:i:s", time()),
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Product ID:' . $order_number . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

    
    public static function chujiatongzhimaijia($config = [], $oid = '', $mid = '', $goods_id = '', $goods_name = '', $now_max_price = '',$is_zc='')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        if($is_zc==1){
            $path = 'pagesB/special/specialGoods/specialGoods?id=' . $goods_id;
        }else{
            $path = 'pagesA/goods/detail?id=' . $goods_id;
        }
        //$path        = 'pagesA/goods/detail?id=' . $goods_id;
        $name        = KeyWordReplace::where(['site_id' => $config['id'], 'xid' => 1])->first()->name;
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

        
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_tellseller'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_tellseller']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => '您的【' . $name . '】有人出价',
                            ],
                        'keyword1' =>
                            [
                                'value' => $goods_id,

                            ],
                        'keyword2' =>
                            [
                                'value' => $goods_name,
                            ],
                        'keyword3' =>
                            [
                                'value' => $now_max_price,
                            ],
                        'keyword4' =>
                            [
                                'value' => date('Y-m-d H:i:s', time()),
                            ],

                    ],
            ]);
            \Yii::getLogger()->log('Produdct id:' . $goods_id . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

      
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_tellseller'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_tellseller']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'  => [
                        'value' => $goods_name,
                    ],
                    'amount2' => [
                        'value' => $now_max_price,
                    ],
                    'thing4'  => [
                        'value' => 'Your product' . $goods_name . 'has an offer',
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Product id:' . $goods_id . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

    public static function fasongxiaoxi($config = [], $oid = '', $mid = '', $user_name = '')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pages/msg/msg';
        $template    = Template::firstOrCreate(['site_id' => $config->id]);
        
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_sendmessage'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_sendmessage']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hello，【' . $config['name'] . '】your have a message',
                            ],
                        'keyword1' =>
                            [
                                'value' => "Please check message",
                            ],
                        'keyword2' =>
                            [
                                'value' => $user_name,
                            ],
                        'keyword3' =>
                            [
                                'value' => "You have a new message, please reply",
                            ],
                        'keyword4' =>
                            [
                                'value' => date("Y-m-d H:i:s", time()),
                            ],
                    ],
            ]);
            \Yii::getLogger()->log('User Name:' . $user_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_sendmessage'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_sendmessage']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'time1'  => [
                        'value' => date('Y-m-d H:i:s', time()),
                    ],
                    'thing2' => [
                        'value' => $user_name,
                    ]
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('User name:' . $user_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

 
    public static function jingpaijieshu($config = [], $oid = '', $mid = '', $goods_id = '', $goods_name = '', $max_price = '', $cut_off_time = '')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesA/goods/detail?id=' . $goods_id;
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

        
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_endpaimai'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_endpaimai']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Auction is ending！',
                            ],
                        'keyword1' =>
                            [
                                'value' => $goods_name,

                            ],
                        'keyword2' =>
                            [
                                'value' => $max_price . "$",
                            ],
                        'keyword3' =>
                            [
                                'value' => $cut_off_time,
                            ],
                        'remark'   =>
                            [
                                'value' => 'Auction is ending, please bid！',
                                'color' => '#FF0000',
                            ],
                    ],
            ]);
            \Yii::getLogger()->log('Product:' . $goods_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }


        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_endpaimai'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_endpaimai']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'  => [
                        'value' => $goods_name,
                    ],
                    'phrase3' => [
                        'value' => '拍品即将结束',
                    ],
                    'thing4'  => [
                        'value' => $cut_off_time,
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Product:' . $goods_name . 'Auction result:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

   
    public static function dianpushangxin($config = [], $oid = '', $mid = '', $goods_id = '', $goods_name = '', $goods_start_price = '', $goods_each_add = '', $is_need_bond = '')
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesA/goods/detail?id=' . $goods_id;
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

      
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_shopnewgoods'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => trim($template['template_shopnewgoods']),
                'url'         => $url . $path,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Your favourite merchant has a new product',
                                'color' => 'red',
                            ],
                        'keyword1' =>
                            [
                                'value' => $goods_name,

                            ],
                        'keyword2' =>
                            [
                                'value' => $goods_start_price,
                            ],
                        'keyword3' =>
                            [
                                'value' => $goods_each_add,
                            ],
                        'keyword4' =>
                            [
                                'value' => date('Y-m-d H:i:s', time()),
                            ],
                        'keyword5' =>
                            [
                                'value' => $is_need_bond,
                            ],

                    ],
            ]);
            \Yii::getLogger()->log('Product:' . $goods_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

     
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_shopnewgoods'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_shopnewgoods']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'  => [
                        'value' => $goods_name,
                    ],
                    'date2'   => [
                        'value' => date('Y-m-d H:i:s', time()),
                    ],
                    'amount4' => [
                        'value' => $goods_start_price,
                    ],
                    'thing3'  => [
                        'value' => 'Your favourite merchant has a new product',
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Product:' . $goods_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

 
    public static function autoshouhuo($config = [], $oid = '', $mid = '', $order)
    {
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesA/order/userOrder/userOrder?s=2';
        $template    = Template::firstOrCreate(['site_id' => $config->id]);

        //公众号通知
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($oid) && !empty($template['template_order_auto_confirm'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $oid,
                'template_id' => $template['template_order_auto_confirm'],
                'url'         => $url,
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hello，【' . $config->name . '】has a new order',
                            ],
                        'keyword1' =>
                            [
                                'value' => $order->serial_number,
                            ],
                        'keyword2' =>
                            [
                                'value' => $order->goods_title,
                            ],
                        'keyword3' =>
                            [
                                'value' => date('Y-m-d H:i:s', strtotime($order->send_at)),
                            ],
                        'keyword4' =>
                            [
                                'value' => date('Y-m-d H:i:s', strtotime($order->auto_confirm_time)),
                            ],
                        'remark'   =>
                            [
                                'value' => 'Please confirm order',
                                'color' => '#898989',
                            ],

                    ],
            ]);
            \Yii::getLogger()->log('Order ID:' . $order->serial_number . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($mid) && !empty($template['mini_template_shouhuo'])) {
            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_shouhuo']),
                'touser'      => $mid,
                'page'        => $path,
                'data'        => [
                    'thing1'            => [
                        'value' => $order->goods_title . 'Auto receipt',
                    ],
                    'character_string2' => [
                        'value' => $order->serial_number,
                    ],
                    'date3'             => [
                        'value' => date("Y-m-d H:i:s", time()),
                    ],
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('Product ID:' . $order->serial_number . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }

    
    public static function zj_appraisal($config, $orderinfo)
    {
        if(!$orderinfo['zjuser_id']){
           return true;
        }
        $zjuserinfo = User::where('id', $orderinfo['zjuser_id'])->where('site_id', $config->id)->first();
        $openid=$zjuserinfo['openid'];
        $miniopenid=$zjuserinfo['mini_openid'];
        $buyuserinfo= User::where('id', $orderinfo['user_id'])->where('site_id', $config->id)->first();
        $buyuser_name=$buyuserinfo['name'];
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesB/jd/expertOrder/expertOrder?s=1';
        $template    = Template::firstOrCreate(['site_id' => $config->id]);
        $types=$orderinfo['is_zj']==1?'Expert Confirmed Order':$orderinfo['jian_title'];
        //公众号通知
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($openid) && !empty($template['template_zjsendmessage'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);

            $result  = $wx_app->template_message->send([
                'touser'      => $openid,
                'template_id' => trim($template['template_zjsendmessage']),
                'url'         => $url . $path,
//                "miniprogram"=>[
//                        "appid"=>trim($config['mini_appid']),
//                        "pagepath"=>$path
//                ],
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hello, you have a new confirmation request',
                            ],
                        'keyword1' =>
                            [
                                'value' =>  $orderinfo['title'],
                            ],
                        'keyword2' =>
                            [
                                'value' => date('Y-m-d H:i:s', time()),
                            ],
                        'keyword3' =>
                            [
                                'value' => $buyuser_name,
                            ],
                        'remark' =>
                            [
                                'value' => 'Please confirm order',
                                'color' => 'blue',
                            ],
                    ],
            ]);
            \Yii::getLogger()->log('User name:' . $buyuser_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

      
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($miniopenid) && !empty($template['mini_template_zjsendmessage'])) {

            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_zjsendmessage']),
                'touser'      => $miniopenid,
                'page'        => $path,
                'data'        => [
                    'character_string1'=>[
                        'value' => $orderinfo['serial_number']
                    ],
                    'time2'  => [
                        'value' => date('Y-m-d H:i:s', time()),
                    ],
                    'thing3' => [
                        'value' => $types,
                    ],
                    'thing4' => [
                        'value' => $buyuser_name,
                    ],
                    'thing7' => [
                        'value' =>'请及时鉴定订单哦~',
                    ]
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('用户姓名:' . $buyuser_name . '发送模板消息小程序发送结果:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }


    public static function zj_apply($config,$orderinfo)
    {

        $zjuserinfo = User::where('id', $orderinfo['zjuser_id'])->where('site_id', $config->id)->first();
        if($orderinfo['is_zj']!=1){
            $user_name='平台';
        }else{
            $user_name=$zjuserinfo['name'];
        }

        $buyuserinfo= User::where('id', $orderinfo['user_id'])->where('site_id', $config->id)->first();
        $openid=$buyuserinfo['openid'];
        $miniopenid=$buyuserinfo['mini_openid'];
        $app_doc_url = \Yii::$app->request->hostInfo . \Yii::$app->request->baseUrl . '/';
        $url         = $app_doc_url . 'h5/?uniacid=' . $config->uniacid . '#/';
        $path        = 'pagesB/jd/order/order?s=2';
        $template    = Template::firstOrCreate(['site_id' => $config->id]);
        
        if (!empty($config['appid']) && !empty($config['appsecret']) && !empty($openid) && !empty($template['template_zjapplymessage'])) {
            $options = [
                'debug'  => true,
                'app_id' => trim($config['appid']),
                'secret' => trim($config['appsecret']),
            ];
            $wx_app  = Factory::officialAccount($options);
            $result  = $wx_app->template_message->send([
                'touser'      => $openid,
                'template_id' => trim($template['template_zjapplymessage']),
                'url'         => $url . $path,
//                "miniprogram"=>[
//                    "appid"=>trim($config['mini_appid']),
//                    "pagepath"=>$path
//                ],
                'data'        =>
                    [
                        'first'    =>
                            [
                                'value' => 'Hello, your order has been confirmed. Please see details',
                            ],
                        'keyword1' =>
                            [
                                'value' => $orderinfo['advise'],
                            ],
                        'keyword2' =>
                            [
                                'value' => date('Y-m-d H:i:s', time()),
                            ],
                        'remark' =>
                            [
                                'value' => 'verifier：'.$user_name.',thanks for your trust',
                            ],
                    ],
            ]);
            \Yii::getLogger()->log('User name:' . $user_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        
        if (!empty($config['mini_appid']) && !empty($config['mini_appsecret']) && !empty($miniopenid) && !empty($template['mini_template_zjapplymessage'])) {

            $options  = [
                'debug'  => true,
                'app_id' => trim($config['mini_appid']),
                'secret' => trim($config['mini_appsecret']),
            ];
            $mini_app = Factory::miniProgram($options);
            $data     = [
                'template_id' => trim($template['mini_template_zjapplymessage']),
                'touser'      => $miniopenid,
                'page'        => $path,
                'data'        => [
                    'date1'  => [
                        'value' => date('Y-m-d H:i:s', time()),
                    ],
                    'thing2' => [
                        'value' => $orderinfo['advise'],
                    ],
                    'name4' => [
                        'value' => $user_name,
                    ]
                ],
            ];
            $result   = $mini_app->subscribe_message->send($data);
            \Yii::getLogger()->log('User name:' . $user_name . 'Order confirmed:' . json_encode($result, JSON_UNESCAPED_UNICODE), Logger::LEVEL_ERROR);
        }

        return true;
    }


    public static function getLevelData($site_id)
    {
        $user_level = UserLevel::whereSiteId($site_id)->select('id', 'integral')->get()->toarray();

        $filter = [
            ['level' => $user_level['0']['id'], 'min' => 0, 'max' => $user_level['1']['integral'] - 1],
            [
                'level' => $user_level['1']['id'],
                'min'   => $user_level['1']['integral'],
                'max'   => $user_level['2']['integral'] - 1,
            ],
            [
                'level' => $user_level['2']['id'],
                'min'   => $user_level['2']['integral'],
                'max'   => $user_level['3']['integral'] - 1,
            ],
            [
                'level' => $user_level['3']['id'],
                'min'   => $user_level['3']['integral'],
                'max'   => $user_level['4']['integral'] - 1,
            ],
            [
                'level' => $user_level['4']['id'],
                'min'   => $user_level['4']['integral'],
                'max'   => $user_level['5']['integral'] - 1,
            ],
            [
                'level' => $user_level['5']['id'],
                'min'   => $user_level['5']['integral'],
                'max'   => $user_level['6']['integral'] - 1,
            ],
            [
                'level' => $user_level['6']['id'],
                'min'   => $user_level['6']['integral'],
                'max'   => $user_level['7']['integral'] - 1,
            ],
            ['level' => $user_level['7']['id'], 'min' => $user_level['7']['integral'], 'max' => 10000000],
        ];

        return $filter;
    }

 
    public static function search($score, $filter)
    {
        $half = floor(count($filter) / 2); 
        
        if ($score <= $filter[$half - 1]['max']) {
            $filter = array_slice($filter, 0, $half);
        } else {
            $filter = array_slice($filter, $half, count($filter));
        }
       
        if (count($filter) != 1) {
            $filter = self::search($score, $filter);
        }

        return $filter;
    }


}
