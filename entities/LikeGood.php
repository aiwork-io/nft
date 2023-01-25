<?php

namespace app\entities;

defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class LikeGood extends BaseEntity
{
    protected $table = 'like_goods';
    protected $guarded = [];
    const UPDATED_AT = null;

    public function goods()
    {
        return $this->belongsTo('app\entities\Goods');
    }

    public function user()
    {
        return $this->belongsTo('app\entities\User');
    }

    public function seller()
    {
        return $this->belongsTo('app\entities\User', 'goods_id');
    }

    public function shops()
    {
        return $this->belongsTo('app\entities\Shops', 'goods_id', 'user_id');
    }

    public function priceOffers()
    {
        return $this->hasMany('app\entities\PriceOffer', 'goods_id', 'goods_id');
    }

}