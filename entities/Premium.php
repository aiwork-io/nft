<?php

namespace app\entities;


defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Premium extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'premium';
    protected $guarded = [];
    public static $status_map = [
        0  => '待支付',
        1  => '已支付'
    ];
    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function shop_level()
    {
        return $this->belongsTo('app\entities\ShopsLevel', 'level');
    }

    public function shops()
    {
        return $this->belongsTo('app\entities\Shops', 'user_id','user_id');
    }
}