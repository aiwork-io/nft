<?php

namespace app\entities;

class Bondorder extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'bondorder';
    protected $guarded = [];

    public static $status_map = [
        -1  => 'cancelled',
        0  => 'pending payment',
        1  => 'paid',
        2  => 'refunded'
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function goods()
    {
        return $this->belongsTo('app\entities\Goods', 'goods_id');
    }

    public function havepayorder()
    {
        return $this->hasOne('app\entities\GoodsOrder','goods_id','goods_id');
    }

    public function priceoffer()
    {
        return $this->hasOne('app\entities\PriceOffer','goods_id','goods_id');
    }


}