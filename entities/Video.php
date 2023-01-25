<?php

namespace app\entities;

class Video extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'video';
    protected $guarded = [];
    const AUTH_NOT = -1;
    const AUTH_NEED = 0;
    const AUTH_PASS = 1;

    public static $auth_statue = [
        self::AUTH_NEED => '待审核',
        self::AUTH_PASS => '审核通过',
        self::AUTH_NOT => '未通过',
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function videoType()
    {
        return $this->belongsTo('app\entities\VideoType', 'video_type_id')->where('is_del',0);
    }

    public function shop()
    {
        return $this->belongsTo('app\entities\Shops', 'user_id', 'user_id');
    }

    public function goods()
    {
        return $this->belongsTo('app\entities\Goods', 'goods_id');
    }

    public function priceOffers()
    {
        return $this->hasMany('app\entities\PriceOffer','goods_id','goods_id');
    }

}
