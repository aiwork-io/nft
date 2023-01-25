<?php

namespace app\entities;
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Zcwallet extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'walletszc';
    protected $guarded = [];
    public function user()
    {
        return $this->belongsTo('app\entities\User', 'user_id');
    }

}
