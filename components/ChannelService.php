<?php

namespace app\components;

use Channel\Client;
use yii\base\Component;

class ChannelService
{
    /**
     * @var Client
     */
    protected $channel;

    /**
     * @var
     */
    protected $trigger = 'feng';

    /**
     * @var ChannelService
     */
    protected static $instance;

    public function __construct()
    {
        self::connet();
    }

    public static function instance()
    {
        if (is_null(self::$instance))
            self::$instance = new self();

        return self::$instance;
    }

    public static function connet()
    {
        $config = [
            //internal port
            'port' => 39998,
            //internal IP
            'ip' => '127.0.0.1',
        ];
        Client::connect($config['ip'], $config['port']);
    }

    /**
     * @param string $name
     * @return $this
     */
    public function setTrigger(string $name)
    {
        $this->trigger = $name;
        return $this;
    }

    /**
     * Send message
     * @param string $type
     * @param array|null $data
     * @param array|null $ids
     */
    public function send(string $type, ?array $data = null, ?array $ids = null)
    {
        $res = compact('type');
        if (!is_null($data))
            $res['data'] = $data;

        if (!is_null($ids) && count($ids))
            $res['ids'] = $ids;

        $this->trigger($this->trigger, $res);
        $this->trigger = 'feng';
    }

    public function trigger(string $type, ?array $data = null)
    {
        Client::publish($type, $data);
    }


}
