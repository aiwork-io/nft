<?php

namespace app\entities;


use Illuminate\Database\Eloquent\Model;

class WalletRechargeOrder extends Model
{
    protected $guarded = [];

    public function merchant()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function user()
    {
        return $this->belongsTo('app\entities\User');
    }
}
