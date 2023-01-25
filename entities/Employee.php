<?php

namespace app\entities;

class Employee extends BaseEntity
{
    protected $table = 'employee';
    protected $guarded = [];

    public function department()
    {
        return $this->belongsTo('app\entities\Department', 'department_id');
    }


}