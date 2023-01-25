<?php

namespace app\entities;

class ActivityJoin extends BaseEntity
{
    protected $table = 'activity_join';


    public function user()
    {
        return $this->belongsTo(User::className());
    }

    public function goods()
    {
        return $this->belongsTo(ActivityGoods::className(), 'activity_goods_id');
    }

    public function activitybejoin()
    {
        return $this->hasMany(ActivityBeJoin::className(), 'activity_join_id', 'id');
    }

}