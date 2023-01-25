<?php

namespace app\components;

use app\entities\OpenSet;
use app\entities\Template;
use yii\base\Component;

class SetRedis extends Component
{

    public static function template($site_id = 1)
    {
        $openredis  = new OpenRedis();
        $open_redis = $openredis->openredis();
        $key = 'ltwlpb_hmg_template_' . $site_id;
        $data   = $open_redis->get($key);
        if (empty($data)) {
            $find_data =  Template::firstOrCreate(['site_id' => $site_id]);
            $open_redis->setex($key, 5,json_encode($find_data));

            $data = $open_redis->get($key);
            $result  = json_decode($data, true);
        } else {
            $result  = json_decode($data, true);
        }
        return $result;
    }

    public static function openset($site_id = 1)
    {
        $openredis  = new OpenRedis();
        $open_redis = $openredis->openredis();
        $key = 'ltwlpb_hmg_template_' . $site_id;
        $data   = $open_redis->get($key);
        if (empty($data)) {
            $find_data =  OpenSet::where('site_id', $site_id)->first();
            $open_redis->setex($key, 5,json_encode($find_data));

            $data = $open_redis->get($key);
            $result  = json_decode($data, true);
        } else {
            $result  = json_decode($data, true);
        }
        return $result;
    }



}