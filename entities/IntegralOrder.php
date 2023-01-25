<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class IntegralOrder extends \Illuminate\Database\Eloquent\Model
{
  protected $table = 'integral_orders';
  protected $guarded = [];


  public static $status_map = [
    -2 => '超时关闭',
    -1 => '订单关闭',
    0  => '待支付',
    1  => '待发货',
    2  => '待签收',
    3  => '已完成'
  ];


  public function user()
  {
    return $this->belongsTo('app\entities\User', 'user_id');
  }

  public function goods()
  {
    return $this->hasOne('app\entities\Goods', 'id', 'goods_id');
  }

  public function seller()
  {
    return $this->belongsTo('app\entities\User', 'goods_user_id');
  }

  public function shop()
  {
    return $this->belongsTo('app\entities\Shops', 'goods_user_id', 'user_id');
  }

  public function after()
  {
    return $this->hasOne('app\entities\AfterSale');
  }

  public function express()
  {
    return $this->belongsTo('app\entities\Express', 'express_id');
  }

  public function walletlist()
  {
    return $this->hasOne('app\entities\Walletlist', 'goods_id', 'goods_id')->orderBy('id', 'desc')->where('type', -8);
  }
}