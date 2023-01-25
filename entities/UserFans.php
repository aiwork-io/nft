<?php

namespace app\entities;

class UserFans extends BaseEntity
{
    protected $table = 'user_fans';
    protected $fillable = [];
    protected $guarded = [];
    protected $primaryKey = 'id';
    public $timestamps = true;

    public function addAll(Array $data)
    {
        $rs = DB::table($this->getTable())->insert($data);
        return $rs;
    }

    public function he()
    {
        return $this->belongsTo('app\entities\User', 'sid');
    }
    public function she()
    {
        return $this->belongsTo('app\entities\User', 'uid');
    }
}