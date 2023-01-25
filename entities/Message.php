<?php


namespace app\entities;

class Message extends BaseEntity
{
    protected $table = 'messages';
    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function seller()
    {
        return $this->belongsTo('app\entities\User', 'seller_id');
    }
}