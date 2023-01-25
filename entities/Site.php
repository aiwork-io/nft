<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/18
 * Time: 7:36
 *
*/
class Site extends BaseEntity
{
    protected $table = 'site';
}