<?php

namespace app\entities;


defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/18
 * Time: 7:36
 */
class Sendmessage extends BaseEntity
{

    //发货通知
    public function send($openid, $user_name,$tokens, $goods_name, $status,$order_number,$gotourl,$template_id)
    {
        $url    = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $tokens;
        $params = [
            'touser'      => $openid,
            'template_id' => $template_id,//模板ID
            'url'         => $gotourl,
            'data'        =>
                [
                    'first'     =>
                        [
                            'value' => '尊敬的' . $user_name,
                            'color' => '#173177',
                        ],
                    'OrderSn' =>
                        [
                            'value' => $order_number,
                            'color' => '#FF0000',
                        ],

                    'OrderStatus' =>
                        [
                            'value' => $status,
                            'color' => '#173177',
                        ],
                    'remark' =>
                        [
                            'value' => '您拍宝成功的商品'.$goods_name.$status,
                            'color' => 'blue',
                        ],
                ],
        ];
        $json   = json_encode($params, JSON_UNESCAPED_UNICODE);

        return $this->curlPost($url, $json);
    }

    public function confirmreceiveordersend($openid, $user_name,$tokens, $goods_name, $status,$order_number,$people_name,$template_id)
    {
        $url    = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $tokens;
        $params = [
            'touser'      => $openid,
            'template_id' => $template_id,//模板ID
            'data'        =>
                [
                    'first'     =>
                        [
                            'value' => '尊敬的' . $user_name,
                            'color' => '#173177',
                        ],
                    'OrderSn' =>
                        [
                            'value' => $order_number,
                            'color' => '#FF0000',
                        ],

                    'OrderStatus' =>
                        [
                            'value' => $status,
                            'color' => '#173177',
                        ],
                    'remark' =>
                        [
                            'value' => $people_name.'拍宝成功的商品'.$goods_name.$status,
                            'color' => 'blue',
                        ],
                ],
        ];
        $json   = json_encode($params, JSON_UNESCAPED_UNICODE);

        return $this->curlPost($url, $json);
    }

    //出价被超越通知
    public function offer_pirce_send($openid,$tokens,$price,$goods_id,$goods_name,$gotourl,$template_id){
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $tokens;
        $params = [
            'touser' => $openid,
            'template_id' => $template_id,//模板ID
            'url' => $gotourl,
            'data' =>
                [
                    'first' =>
                        [
                            'value' => '感谢您参与拍卖，您的出价'.$price.'已被超越。',
                            'color' => '#173177'
                        ],
                    'number' =>
                        [
                            'value' => $goods_id,
                            'color' => '#FF0000'
                        ],

                    'name' =>
                        [
                            'value' => $goods_name,
                            'color' => '#173177'
                        ],
                    'remark' =>
                        [
                            'value' => '请立即前往查看',
                            'color' => 'blue'
                        ]
                ]
        ];
        $json = json_encode($params,JSON_UNESCAPED_UNICODE);
        return $this->curlPost($url, $json);
    }

    //获取截止时间的订单
    public function orders_send($openid, $tokens, $goods_name, $order_time, $order_number,$gotourl,$template_id)
    {
        $url    = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $tokens;
        $params = [
            'touser'      => $openid,
            'template_id' => $template_id,//模板ID
            'url'         => $gotourl,
            'data'        =>
                [
                    'first'     =>
                        [
                            'value' => '您好，您在拍宝成功拍下' . $goods_name . '，订单已经生成，请尽快前往支付',
                            'color' => '#173177',
                        ],
                    'ordertape' =>
                        [
                            'value' => $order_time,
                            'color' => '#FF0000',
                        ],

                    'ordeID' =>
                        [
                            'value' => $order_number,
                            'color' => '#173177',
                        ],
                    'remark' =>
                        [
                            'value' => '还未支付，请及时去付款',
                            'color' => 'blue',
                        ],
                ],
        ];
        $json   = json_encode($params, JSON_UNESCAPED_UNICODE);

        return $this->curlPost($url, $json);
    }

    //通知商家发货
    public function orders_sendgoods($openid, $tokens, $goods_name, $order_time, $order_number,$gotourl,$template_id)
    {
        $url    = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $tokens;
        $params = [
            'touser'      => $openid,
            'template_id' => $template_id,//模板ID
            'url'         => $gotourl,
            'data'        =>
                [
                    'first'     =>
                        [
                            'value' => '您好，买家在拍宝成功拍下' . $goods_name . '的订单已经支付，请及时发货',
                            'color' => '#173177',
                        ],
                    'ordertape' =>
                        [
                            'value' => $order_time,
                            'color' => '#FF0000',
                        ],

                    'ordeID' =>
                        [
                            'value' => $order_number,
                            'color' => '#173177',
                        ],
                    'remark' =>
                        [
                            'value' => '请及时发货',
                            'color' => 'blue',
                        ],
                ],
        ];
        $json   = json_encode($params, JSON_UNESCAPED_UNICODE);

        return $this->curlPost($url, $json);
    }

    protected function curlPost($url, $data)
    {
        $ch                             = curl_init();
        $params[CURLOPT_URL]            = $url;    //请求url地址
        $params[CURLOPT_HEADER]         = false; //是否返回响应头信息
        $params[CURLOPT_SSL_VERIFYPEER] = false;
        $params[CURLOPT_SSL_VERIFYHOST] = false;
        $params[CURLOPT_RETURNTRANSFER] = true; //是否将结果返回
        $params[CURLOPT_POST]           = true;
        $params[CURLOPT_POSTFIELDS]     = $data;
        curl_setopt_array($ch, $params); //传入curl参数
        $content = curl_exec($ch); //执行
        curl_close($ch); //关闭连接
        //da($content);
        return $content;
    }
}