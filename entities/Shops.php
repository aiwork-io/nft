<?php

namespace app\entities;

use Carbon\Carbon;

defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class Shops extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'shops';
    protected $guarded = [];
    const AUTH_BLANK = 0;
    const AUTH_NEED = 1;
    const AUTH_PASS = 5;
    const AUTH_NOT = 3;

    public static $auth_statue = [
        self::AUTH_BLANK => '待完善',
        self::AUTH_NEED  => '待认证',
        self::AUTH_PASS  => '认证通过',
        self::AUTH_NOT   => '认证未通过',
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function shopLevel()
    {
        return $this->hasOne('app\entities\ShopsLevel', 'id', 'level');
    }

    public function goods()
    {
        return $this->hasMany('app\entities\Goods', 'user_id', 'user_id');
    }

    public function limitGoods()
    {
        return $this->hasMany('app\entities\Goods', 'user_id', 'user_id')->where([
            'issale' => 1,
            'status' => 1,
        ])->where('is_live', '<>',1)->where('cut_off_time','>',Carbon::now())->select('id', 'user_id', 'images')->orderBy('created_at', 'DESC')->limit(5);
    }

    public function diamonds()
    {
        return $this->belongsTo('app\entities\Diamonds', 'user_id', 'user_id');
    }

    public function wallet_lists()
    {
        return $this->belongsTo('app\entities\WalletList', 'user_id', 'user_id');
    }

    public function order()
    {
        return $this->hasMany('app\entities\GoodsOrder', 'goods_user_id', 'user_id')->where('status', '>', 0)->where('virtual_order', 0);
    }


}