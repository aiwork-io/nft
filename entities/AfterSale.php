<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class AfterSale extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'after_sale';
    protected $guarded = [];
    const AUTH_NEED = 0;
    const AUTH_PASS = 1;
    const AUTH_REFUSE = 2;
    const AUTH_GOODS = 3;
    const AUTH_CONFIRM = 4;

    const COMP_AUTH_NEED = 0;
    const COMP_AUTH_PASS = 1;

    public static $auth_statue = [
      self::AUTH_NEED    => 'processing',
      self::AUTH_PASS    => 'approved',
      self::AUTH_REFUSE  => 'rejected',
      self::AUTH_GOODS   => 'delivering',
      self::AUTH_CONFIRM => 'return successful',
    ];

    public static $complaint_statue = [
      self::COMP_AUTH_NEED => 'processing',
      self::COMP_AUTH_PASS => 'processed',
    ];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function seller()
    {
        return $this->belongsTo('app\entities\User', 'goods_shop_id');
    }

    public function shop(){
      return $this->belongsTo('app\entities\Shops','goods_shop_id','user_id');
    }

    public function express()
    {
        return $this->belongsTo('app\entities\Express', 'express_name');
    }

    public function order()
    {
        return $this->belongsTo('app\entities\GoodsOrder', 'goods_order_id');
    }


}