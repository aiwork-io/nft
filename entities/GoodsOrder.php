<?php

namespace app\entities;

defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class GoodsOrder extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'goods_orders';
    protected $guarded = [];
    const QUIT_GOODS = -3;
    const AUTH_NEED = 0;
    const AUTH_PASS = 1;
    const AUTH_GET = 2;
    const AUTH_SUCCESS = 3;

    public static $auth_statue = [
        self::QUIT_GOODS => '售后',
        self::AUTH_NEED => '待付款',
        self::AUTH_PASS => '待发货',
        self::AUTH_GET => '待收货',
        self::AUTH_SUCCESS => '已完成',
    ];

    public static $status_map = [
        -1 => '订单取消',
        -2 => '订单关闭',
        -3 => '订单售后',
        0 => '待支付',
        1 => '待发货',
        2 => '待签收',
        3 => '已完成',
        4 => '已评价',
    ];

    public static $order_status = [
        0 => '待支付',
        1 => '待发货',
        2 => '待签收',
        3 => '已完成',
        9 => '全部',
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function goods()
    {
        return $this->hasOne('app\entities\Goods', 'id', 'goods_id');
    }

    public function seller()
    {
        return $this->belongsTo('app\entities\User', 'goods_user_id');
    }

    public function shop()
    {
        return $this->belongsTo('app\entities\Shops', 'goods_user_id', 'user_id');
    }

    public function after()
    {
        return $this->hasOne('app\entities\AfterSale', 'goods_order_id', 'id');
    }

    public function express()
    {
        return $this->belongsTo('app\entities\Express', 'express_id');
    }

    public function bonderorder()
    {
        return $this->hasOne('app\entities\Bondorder', 'goods_id', 'goods_id')->where('status', 1)->orderBy('id', 'desc');
    }

    public function havebonder()
    {
        return $this->hasMany('app\entities\Bondorder', 'goods_id', 'goods_id')->where('status', 1)->orderBy('id', 'desc');
    }
}