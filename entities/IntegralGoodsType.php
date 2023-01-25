<?php


namespace app\entities;
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class IntegralGoodsType extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'integral_goods_type';
    protected $guarded = [];

    public function integralgoodstype()
    {
        return $this->hasOne('app\entities\IntegralGoodsType', 'id', 'pid');
    }


}