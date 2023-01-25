<?php

namespace app\entities;

class Goods extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'goods';
    protected $guarded = [];
    const AUTH_NOT_EXIST = -3;
    const AUTH_GO        = -2;
    const AUTH_OUT       = -1;
    const AUTH_NEED      = 0;
    const AUTH_PASS      = 1;
    const AUTH_NOT       = 2;

    const NOTEXCELLENT = 0;
    const EXCELLENT    = 1;

    public static $auth_statue = [
        self::AUTH_NOT_EXIST => '已重新上架',
        self::AUTH_GO        => '已截拍',
        self::AUTH_OUT       => '已流拍',
        self::AUTH_NEED      => '待审核',
        self::AUTH_PASS      => '审核通过,竞拍中',
        self::AUTH_NOT       => '审核未通过',
    ];

    public static $excellent_status = [
        self::NOTEXCELLENT => '不推荐',
        self::EXCELLENT    => '推荐',
    ];


    public function user()
    {
        return $this->belongsTo('app\entities\User');
    }

    public function goodsType()
    {
        return $this->belongsTo('app\entities\GoodsType', 'goods_type_id');
    }

    public function goodsTags()
    {
        return $this->hasMany('app\entities\GoodsTag');
    }

    public function priceOffers()
    {
        return $this->hasMany('app\entities\PriceOffer');
    }

    public function retainoffer()
    {
        return $this->belongsTo('app\entities\PriceOffer','goods_id','id');
    }

    public function priceoffersuser()
    {
        return $this->hasMany('app\entities\PriceOffer')->with('user')->orderBy('id','desc');
    }

    public function getImagesAttribute($images)
    {
        if (empty($images)) {
            return [];
        } else {
            return json_decode($images, true);
        }
    }

    public function setImagesAttribute($data)
    {
        if (empty($data) || !is_array($data)) {
            return $this->attributes['images'] = '';
        }
        $data = array_filter($data);

        $this->attributes['images'] = json_encode($data);
    }

    public function tags()
    {
        return $this->belongsToMany('app\entities\Tag');
    }

    public function history()
    {
        return $this->hasMany('app\entities\Browse');
    }

    public function shop()
    {
        return $this->belongsTo('app\entities\Shops', 'user_id', 'user_id');
    }

    public function comment()
    {
        return $this->hasMany('app\entities\Message', 'goods_id');
    }

    public function comrate()
    {
        return $this->belongsTo('app\entities\CommissionRate', 'retail', 'id');
    }

    public function bondorder()
    {
        return $this->hasMany('app\entities\Bondorder')->where('status', 1)->orderBy('id', 'desc');;
    }

    public function oneprice()
    {
        return $this->hasOne('app\entities\PriceOffer');
    }

    public function maxprice()
    {
        return $this->hasOne('app\entities\PriceOffer')->where('max_id',1)->where('is_order',0)->orderBy('id','desc');
    }

    public function order()
    {
        return $this->hasOne('app\entities\GoodsOrder');
    }

    public function showgoods()
    {
        return $this->belongsTo('app\entities\Specialshow','special_show_id','id');
    }


}