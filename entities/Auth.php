<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Auth extends BaseEntity
{
    protected $table = 'auth';


    public function goods()
    {
        return $this->belongsToMany(Goods::className());
    }
}