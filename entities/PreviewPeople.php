<?php

namespace app\entities;


class PreviewPeople extends BaseEntity
{
    protected $table = 'preview_people';
    protected $guarded = [];
    public function user()
    {
        return $this->belongsTo('app\entities\User');
    }

    public function goods()
    {
        return $this->belongsTo('app\entities\Goods','goods_id');
    }
}
