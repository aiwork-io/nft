<?php

namespace app\entities;

class UserChat extends BaseEntity
{
    protected $table = 'user_chat';
    protected $fillable = [];
    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo('app\entities\User', 'uid');
    }

    public function seller()
    {
        return $this->belongsTo('app\entities\User', 'sid');
    }
}