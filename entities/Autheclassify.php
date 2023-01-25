<?php

namespace app\entities;

defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class Autheclassify extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'authenticate_classify';
    protected $guarded = [];


   
}