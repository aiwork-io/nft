<?php

namespace app\entities;

defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class WalletList extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'wallet_lists';
    protected $guarded = [];

    public static $type_map = [
        -1 => '提现',
        -2 => '订单支付',
        -3 => '支付消保金',
        -4 => '升级商铺',
        -5 => '拼团限量退款',
        -6 => '后台手动减少',
        -7 => '升级会员',
        -8 => '支付直播',
        -9 => '支付广告位',

        1  => '订单收入',
        2  => '充值',
        3  => '分享奖励金',
        4  => '拼团收入',
        5  => '售后退款',
        6  => '后台手动添加',
        7  => '消保金退款',
        8  => '买家订单未支付，保证金奖励',
        9  => '保证金提现，提现到余额',
        10 => '出价红包奖励',
    ];

    public static $status_map = [
        -1 => '失败',
        0  => '待处理',
        1  => '完成',
    ];

    public static $status_applyforfee_map = [
        -1 => '已拒绝',
        0  => '待提现',
        1  => '已提现',
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function order()
    {
        return $this->belongsTo('app\entities\GoodsOrder', 'order_id', 'id');
    }

    public function userbenefits()
    {
        return $this->hasMany('app\entities\UserBenefits', 'orders_id', 'order_id');
    }

    public function merchant()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    //远程一对一
    public function usertwo()
    {
        return $this->hasOneThrough('app\entities\User', 'app\entities\GoodsOrder', 'id', 'id', 'order_id', 'user_id');
    }

}
