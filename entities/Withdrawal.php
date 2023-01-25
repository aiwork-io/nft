<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Withdrawal extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'wallet_lists';
    protected $guarded = [];
    const AUTH_NEED    = 0;
    const AUTH_PASS    = 1;
    const AUTH_GET     = -1;

    public static $auth_statue = [
        self::AUTH_NEED    => '待审核',
        self::AUTH_PASS    => '审核通过',
        self::AUTH_GET     => '审核拒绝'
    ];

    public static $status_map = [
        -1 => '订单取消',
        -2 => '订单关闭',
        0  => '待支付',
        1  => '待发货',
        2  => '待签收',
        3  => '已完成',
    ];

    public function merchant()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function goods()
    {
        return $this->hasOne('app\entities\Goods', 'goods_id', 'id');
    }

    public function userwallet()
    {
        return $this->belongsTo('app\entities\Wallet', 'user_id','user_id');
    }
}