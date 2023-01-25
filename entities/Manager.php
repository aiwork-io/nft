<?php

namespace app\entities;
use app\entities\Role;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Manager extends BaseEntity
{
    protected $table = 'manager';


    public function role()
    {
        return $this->hasOne(Role::className(), 'role_id', 'mg_role_id');
    }
}