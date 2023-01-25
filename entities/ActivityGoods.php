<?php

namespace app\entities;

class ActivityGoods extends BaseEntity
{
    protected $table = 'activity_goods';

    public function setImagesAttribute($data)
    {
        if (empty($data) || !is_array($data)) {
            return $this->attributes['images'] = '';
        }
        $data = array_filter($data);

        $this->attributes['images'] = json_encode($data);
    }

    public function getImagesAttribute($images)
    {
        if (empty($images)) {
            return [];
        } else {
            return json_decode($images, true);
        }
    }

    public function join_num()
    {
        return $this->hasMany(ActivityJoin::className(), 'activity_goods_id')->where('status','>',0);
    }

}