<?php

namespace app\entities;

class Diamonds extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'diamonds';
    protected $guarded = [];
    public static $status_map = [
        0 => 'pending payment',
        1 => 'paid'
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function shops()
    {
        return $this->belongsTo('app\entities\Shops', 'user_id', 'user_id');
    }

    public function shop_level()
    {
        return $this->belongsTo('app\entities\ShopsLevel', 'level');
    }

}
