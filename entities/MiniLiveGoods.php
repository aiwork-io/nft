<?php

namespace app\entities;

class MiniLiveGoods extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'mini_live_goods';
    protected $guarded = [];

    public function product()
    {
        return $this->hasOne(Goods::class, 'id', 'product_id');
    }
}
