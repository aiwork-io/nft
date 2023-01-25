<?php

namespace app\entities;

class GoodsType extends BaseEntity
{
    protected $table = 'goods_type';
    protected $guarded = [];

    public function goods()
    {
        return $this->hasMany('app\entities\Goods', 'goods_type_id');
    }

    public function goodstype()
    {
        return $this->hasOne('app\entities\Goodstype', 'id', 'pid');
    }

    public function parent()
    {
        return $this->belongsTo('app\entities\Goodstype', 'pid');
    }

}