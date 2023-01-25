<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Tag extends BaseEntity
{
    protected $table = 'tag';
    protected $guarded = [];


    public function goods()
    {
        return $this->belongsToMany('app\entities\Goods');
    }
}