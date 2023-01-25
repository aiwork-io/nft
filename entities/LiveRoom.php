<?php

namespace app\entities;

defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class LiveRoom extends BaseEntity
{
    protected $table = 'live_room';
    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function goods()
    {
        return $this->hasMany('app\entities\Goods', 'user_id', 'user_id');
    }

    public function liveapply()
    {
        return $this->hasOne('app\entities\LiveApply', 'user_id', 'user_id');
    }

    public function shop()
    {
        return $this->belongsTo('app\entities\Shops', 'user_id', 'user_id');
    }

}