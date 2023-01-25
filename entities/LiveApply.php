<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class LiveApply extends BaseEntity
{
    protected $table = 'live_apply';
    protected $guarded = [];
    const AUTH_NEED   = 0;
    const AUTH_PASS   = 1;
    const AUTH_REFUSE = 2;

    const COMP_AUTH_NEED   = 0;
    const COMP_AUTH_PASS   = 1;
    const COMP_AUTH_REFUSE = 2;

    public static $auth_statue = [
        self::AUTH_NEED   => '待处理',
        self::AUTH_PASS   => '已同意',
        self::AUTH_REFUSE => '已拒绝',
    ];

    public static $complaint_statue = [
        self::COMP_AUTH_NEED   => '待处理',
        self::COMP_AUTH_PASS   => '已处理',
        self::COMP_AUTH_REFUSE => '已处理',
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function order()
    {
        return $this->belongsTo('app\entities\GoodsOrder', 'goods_order_id');
    }


}