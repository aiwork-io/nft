<?php

namespace app\entities;

class ActivityOrder extends BaseEntity
{
    protected $table = 'activity_order';

    public static $status_map = [
      1 => 'pending redemption',
      2 => 'pending delivery',
      3 => 'pending receipt',
      4 => 'completed',
    ];

    public function goods()
    {
        return $this->belongsTo(ActivityGoods::className(), 'activity_goods_id');
    }

    public function user()
    {
        return $this->belongsTo(User::className(), 'user_id');
    }

}