<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/7/28
 * Time: 10:40
 */
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

if(!function_exists('test')){
    function test()
    {
        die(PHP_VERSION);
    }
}


/**
 * 调试打印
 */
if(!function_exists('da')){
    function da()
    {
        header("Content-type:text/html;charset=utf-8");
        $args = func_get_args();
        echo '<pre>';
        foreach ($args as $arg){
            print_r($arg);
            echo '<br />';
        }
        die;
    }
}

/**
 * 调试打印
 */
if(!function_exists('dv')){
    function dv()
    {
        header("Content-type:text/html;charset=utf-8");
        $args = func_get_args();
        echo '<pre>';
        foreach ($args as $arg){
            var_dump($arg);
            echo '<br />';
        }
        die;
    }
}
