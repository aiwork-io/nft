<?php


namespace app\entities;
defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class IntegralGoods extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'integral_goods';
    protected $guarded = [];


    public function integralGoodsType()
    {
        return $this->belongsTo('app\entities\IntegralGoodsType', 'goods_type_id');
    }

    public function order()
    {
        return $this->hasMany('app\entities\IntegralOrder', 'goods_id', 'id');
    }

}