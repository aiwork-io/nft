<?php

namespace app\entities;

class AdOrder extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'ad_order';
    protected $guarded = [];

    public function goodsinfo()
    {
        return $this->hasOne('app\entities\Goods', 'id', 'goods_id');
    }

    public function userinfo()
    {
        return $this->hasOne('app\entities\User', 'id', 'user_id');
    }
}