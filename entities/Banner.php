<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Banner extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'banner';
    protected $guarded = [];


}