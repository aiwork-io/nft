<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/21
 * Time: 14:41
 */
namespace app\entities;

class UserLevel extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'user_level';
    protected $guarded = [];

    public static function defaultLevel($sid)
    {
        $level = self::where('site_id',$sid)->where('is_default',1)->first();
        if (is_null($level)) {
            $level = self::where('site_id',$sid)->orderBy('id')->first();
        }

        return $level;
    }
}