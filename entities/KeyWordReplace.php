<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class KeyWordReplace extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'key_word_replace';
    protected $guarded = [];


}