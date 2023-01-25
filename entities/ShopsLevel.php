<?php

namespace app\entities;


defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class ShopsLevel extends BaseEntity
{
    protected $table = 'shops_level';
    protected $guarded = [];

}