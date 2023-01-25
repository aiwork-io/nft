<?php

namespace app\components;

use yii\base\Component;

class OpenRedis extends Component
{
    public $_config;
    public $_redis;

    public function __construct()
    {
        $config        = [
            'host'           => '127.0.0.1',
            'port'           => 6379,
            'index'          => 0,
            'auth'           => '',
            'timeout'        => 1,
            'reserved'       => null,
            'retry_interval' => 100,
        ];
        $this->_config = $config;
    }

    private function connect()
    {

        $redis = new \Redis();
        $redis->connect($this->_config['host'], $this->_config['port'], $this->_config['timeout'], $this->_config['reserved'], $this->_config['retry_interval']);
        if (!empty($this->_config['auth'])) {
            $redis->auth($this->_config['auth']);
        }
        $redis->select($this->_config['index']);

        return $redis;
    }

    public function openredis()
    {
        return $this->connect();
    }


}
