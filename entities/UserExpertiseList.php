<?php

namespace app\entities;
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));
class UserExpertiseList extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'user_expertise_list';
    protected $guarded = [];


}