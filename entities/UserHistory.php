<?php

namespace app\entities;

class UserHistory extends BaseEntity
{
    protected $table = 'user_history';

    public function me()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

    public function he()
    {
        return $this->belongsTo('app\entities\User', 'sid');
    }
}