<?php

namespace app\entities;

class AssembleOrder extends BaseEntity
{
    protected $table = 'assemble_order';


    public function user()
    {
        return $this->belongsTo(User::className());
    }

    public function goods()
    {
        return $this->belongsTo(Goods::className(), 'goods_id');
    }

    public function activitybejoin()
    {
        return $this->hasMany(ActivityBeJoin::className(), 'activity_join_id', 'id');
    }

}