<?php

namespace app\entities;

class ActivityBeJoin extends BaseEntity
{
    protected $table = 'activity_be_join';

    public function user()
    {
        return $this->belongsTo(User::className(), 'user_id');
    }

    public function be_user()
    {
        return $this->belongsTo(User::className(), 'be_user_id');
    }

    public function goods()
    {
        return $this->belongsTo(Goods::className(), 'goods_id');
    }
}