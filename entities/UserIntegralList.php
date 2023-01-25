<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class UserIntegralList extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'user_interal_lists';
    protected $guarded = [];
    public static $type_map = [
        -2 => '积分兑换',
        -1 => '退货扣除',
        1  => '订单支付',
        2  => '完善资料',
        3  => '邀请好友',
        4  => '签到获取'
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }


}


