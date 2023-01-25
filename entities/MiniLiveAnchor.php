<?php

namespace app\entities;

class MiniLiveAnchor extends \Illuminate\Database\Eloquent\Model
{

    protected $table = 'mini_live_anchor';
    protected $guarded = [];

    public function room()
    {
        return $this->hasOne(LiveRoom::class, 'anchor_wechat', 'wechat');
    }

}
