<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class UserBenefits extends BaseEntity
{
    protected $table = 'user_benefits';
    protected $guarded = [];

    public static $status_map = [
        -1 => '退款',
        0  => '未结算',
        1  => '已结算',
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function parent_user()
    {
        return $this->belongsTo('app\entities\User','parent_id');
    }

    public function orders()
    {
        return $this->belongsTo('app\entities\GoodsOrder', 'orders_id');
    }
}