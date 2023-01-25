<?php

namespace app\entities;

class MiniLiveRoom extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'mini_live_room';
    protected $guarded = [];

    public function roomGoods()
    {
        return $this->hasMany(MiniLiveRoomGoods::class, 'live_room_id', 'id');
    }

    public function anchor()
    {
        return $this->hasOne(MiniLiveAnchor::class, 'wechat', 'anchor_wechat')->where('is_show', 1)->where('is_del', 0);
    }

}
