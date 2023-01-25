<?php

namespace app\entities;

defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class Authegoodsorder extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'authenticate_order';
    protected $guarded = [];

    public static $order_status = [
        -1 => 'transaction is closed',
        0  => 'pending payment',
        1  => 'payment successful，pending confirmation',
        2  => 'confirmation complete',
    ];
    public static $really_status = [
        0 => 'unconfirmed',
        1 => 'genuine',
        2 => 'suspicious',
        3 => 'fake'
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function category()
    {
        return $this->belongsTo('app\entities\AuthenticateBelong', 'goods_type_id');
    }

    public function userappraiserlist()
    {
        return $this->belongsTo('app\entities\UserAppraiserList', 'zjuser_id', 'user_id');
    }


}
