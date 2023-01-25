<?php

namespace app\entities;


defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class CommissionRate extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'commission_rate';

    protected $guarded = [];

}