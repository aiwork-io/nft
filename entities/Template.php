<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/18
 * Time: 7:36
 */
class Template extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'template';
    protected $guarded = [];
    
    public static function className()
    {
        return get_called_class();
    }
}