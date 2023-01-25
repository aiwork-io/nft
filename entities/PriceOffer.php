<?php

namespace app\entities;

class PriceOffer extends BaseEntity
{
    protected $table = 'price_offer';
    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo('app\entities\User');
    }

    public function goods()
    {
        return $this->belongsTo('app\entities\Goods','goods_id');
    }

    public function goodsorder()
    {
        return $this->hasOne('app\entities\GoodsOrder', 'goods_id', 'goods_id');
    }

    public function bonder()
    {
        return $this->hasMany('app\entities\Bondorder','goods_id','goods_id')->where("status",1);
    }
}