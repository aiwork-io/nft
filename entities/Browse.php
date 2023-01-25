<?php

namespace app\entities;

class Browse extends BaseEntity
{
    protected $table = 'browse';
    protected $guarded = [];

    public function goods()
    {
        return $this->belongsTo('app\entities\Goods','goods_id');
    }
}