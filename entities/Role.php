<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Role extends BaseEntity
{
    protected $table = 'role';


    public function goods()
    {
        return $this->belongsToMany(Goods::className());
    }
}