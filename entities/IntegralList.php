<?php

namespace app\entities;
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));
class IntegralList extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'integral_list';
    protected $guarded = [];

    public static $type_map = [
        1  => '订单支付',
        2  => '邀请新用户',
        3  => '完善资料',

    ];
    

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }




}
