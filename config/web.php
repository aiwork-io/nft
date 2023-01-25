<?php
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));
defined('IN_IA') or define('IN_IA', true);

$params = require __DIR__ . '/params.php';
$db =require __DIR__ . '/database.php';


/** @var array $config we7 config */

//if (empty($config['db']['master'])) {
//    $db = $config['db'];
//} else {
//    $db = $config['db']['master'];
//}

$config = [
    'id'             => 'basic',
    'language'       => 'zh-CN',
    'sourceLanguage' => 'zh-CN',
    'timeZone'       => 'Asia/Shanghai',
    'basePath'       => dirname(__DIR__),
    'bootstrap'      => ['log'],
    'aliases'        => [

    ],
    'components'     => [
        'request'      => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey'  => 'JHF9ltRKJ4q8x6x19MTbYJAoNhU6PuqO',
            'enableCsrfValidation' => false,
        ],
        'user'         => [
            'identityClass' => 'app\entities\User',
            'class'         => 'yii\web\User',
        ],
        'session'      => [
            'class'        => 'yii\web\Session',
            'timeout'      => 86400,  //10天
            'cookieParams' => [
                'lifetime' => 86400,
            ]
        ],
        'cache'        => [
            'class' => 'yii\caching\FileCache',
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'log'          => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets'    => [
                [
                    'class'  => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'urlManager'   => [
            'enablePrettyUrl'     => true,
            'showScriptName'      => true,
            'enableStrictParsing' => false,
            'rules'               => [
                [
                    'class' => 'app\components\WechatUrlRule',
                ],
            ],
        ],
        /*
        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
            ],
        ],
        */
        'db'           => [
            'class'    => 'yii\db\Connection',
            'dsn'      => 'mysql:host=' . $db['host'] . ';dbname=' . $db['database'],
            'username' => $db['username'],
            'password' => $db['password'],
        ],
    ],
    'params'         => $params,
    'modules'        => [
        'home'  => 'app\modules\home\Module',
        'admin' => 'app\modules\admin\Module',
        'api'   => 'app\modules\api\Module',
    ],
    'defaultRoute'   => 'api/index/index',
];


return $config;
