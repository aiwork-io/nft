<?php

namespace app\entities;

class MiniLiveRoomGoods extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'mini_live_room_goods';
    protected $guarded = [];

    public function goods()
    {
        return $this->hasOne(MiniLiveGoods::class, 'id', 'live_goods_id');
    }

    public function room()
    {
        return $this->hasOne(MiniLiveRoom::class, 'id', 'live_room_id');
    }
}
