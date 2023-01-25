<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/18
 * Time: 7:32
 */

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));
defined('IN_IA') or define('IN_IA',true);
//require __DIR__ . '/../../../../data/config.php';


//$db = [];

/** @var array $config  we7 config*/

//if(empty($config['db']['master'])){
//    $db = $config['db'];
//}else{
//    $db = $config['db']['master'];
//}

return [
    'driver'    => 'mysql',
    'host'      => '127.0.0.1',
    'database'  => 'nft_hotactives',
    'username'  => 'nft_hotactives',
    'password'  => '6wyk4HwZZ5JiByGm',
    'charset'   => 'utf8mb4',
    'collation' => 'utf8mb4_general_ci',
    'prefix'    => 'ltwlpb_',
];