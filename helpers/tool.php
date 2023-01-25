<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/18
 * Time: 8:55
 */
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

/**
 * 前台url
 * home_url('index/index') ====>   /index.php?r=home/index/index
 * home_url(['index/index','id'=>1]) ====>   /index.php?r=home/index/index&id=1
 * @param string $url
 *
 * @return string
 */
function home_url($url = '')
{
    if (is_string($url)) {
        $url = 'home/'.ltrim($url,'/');
    }
    if (is_array($url)) {
        $url[0] = 'home/' . ltrim($url[0],'/');
    }
    $urlManager = \Yii::$app->urlManager;
    return $urlManager->createUrl($url);
}
function api_url($url = '')
{
    if (is_string($url)) {
        $url = 'api/'.ltrim($url,'/');
    }
    if (is_array($url)) {
        $url[0] = 'api/' . ltrim($url[0],'/');
    }
    $urlManager = \Yii::$app->urlManager;
    return $urlManager->createUrl($url);
}
function app_url($url = '')
{
    if (is_string($url)) {
        $url = 'webapp/'.ltrim($url,'/');
    }
    if (is_array($url)) {
        $url[0] = 'webapp/' . ltrim($url[0],'/');
    }
    $urlManager = \Yii::$app->urlManager;
    return $urlManager->createUrl($url);
}

/**
 * 后台url
 * @param $url
 *
 * @return string
 */
function admin_url($url)
{
    if (is_string($url)) {
        $url = 'admin/'.ltrim($url,'/');
    }
    if (is_array($url)) {
        $url[0] = 'admin/' . ltrim($url[0],'/');
    }
    $urlManager = \Yii::$app->urlManager;
    return $urlManager->createUrl($url);

}

/**
 * 模板中用于获取目录资源路径
 * web_url('home/js/jquery.js')
 * @param string $path
 *
 * @return bool|string
 */
function web_url($path = '')
{
    if(strpos($path, "http://")===false && strpos($path, "https://")===false){
        return \Yii::getAlias('@web/'.ltrim($path,'/'));
    }else{
        return $path;
    }

}


/**
 * 判断php版本
 */
if ( ! function_exists('is_php'))
{
    function is_php($version)
    {
        static $_is_php;
        $version = (string) $version;

        if ( ! isset($_is_php[$version]))
        {
            $_is_php[$version] = version_compare(PHP_VERSION, $version, '>=');
        }

        return $_is_php[$version];
    }
}

if(! function_exists('get_server_ip')) {

    function get_server_ip()
    {
        if (isset($_SERVER)) {
            if ($_SERVER['SERVER_ADDR']) {
                $server_ip = $_SERVER['SERVER_ADDR'];
            } else {
                $server_ip = $_SERVER['LOCAL_ADDR'];
            }
        } else {
            $server_ip = getenv('SERVER_ADDR');
        }

        return $server_ip;
    }

}

if(! function_exists('hw_unique')){
    /**
     * 生成唯一的字符串
     * @return string
     */
    function hw_unique()
    {
        return md5(uniqid(md5(microtime(true)),true));
    }
}
if(! function_exists('setLocalImage')) {
    /**
    *功能：php完美实现下载远程图片保存到本地
    *参数：文件url,保存文件目录,保存文件名称，使用的下载方式
    *当保存文件名称为空时则使用远程文件原来的名称
    */
    function setLocalImage($url, $save_dir = 'uploads/image', $filename = '', $type = 1,$width = null, $height = null)
    {
        if (trim($url) == '') {
            return array('file_name' => '', 'save_path' => '', 'error' => 1);
        }
        if (trim($save_dir) == '') {
            $save_dir = './';
        }
        $mimes=array(
            'image/bmp'=>'bmp',
            'image/gif'=>'gif',
            'image/jpeg'=>'jpg',
            'image/png'=>'png',
            'image/x-icon'=>'ico'

        );
        if (trim($filename) == '') {//保存文件名
            if(($headers=get_headers($url, 1))!==false){
                // 获取响应的类型
                $ext=$mimes[$headers['Content-Type']];
            }else{
                $ext='jpg';
            }
            $filename = hw_unique() . '.'.$ext;
        }
        if (0 !== strrpos($save_dir, '/')) {
            $save_dir .= '/';
        }
        //创建保存目录
        if (!file_exists($save_dir) && !mkdir($save_dir, 0777, true)) {
            return array('file_name' => '', 'save_path' => '', 'error' => 5);
        }
        //获取远程文件所采用的方法
        if ($type) {
            $ch = curl_init();
            $timeout = 5;
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
            $img = curl_exec($ch);
            curl_close($ch);
        } else {
            ob_start();
            $url = str_replace('https://', 'http://', $url);
            readfile($url);
            $img = ob_get_contents();
            ob_end_clean();
        }
        //$size=strlen($img);
        //文件大小
        $fp2 = @fopen($save_dir . $filename, 'a');
        fwrite($fp2, $img);
        fclose($fp2);
        unset($img, $url);
        if($width && $height){
            mkThumbnail($save_dir . $filename,$width,$height,$save_dir . $filename);
        }
        return array('file_name' => $filename, 'save_path' => $save_dir . $filename, 'error' => 0);
    }
}
if(! function_exists('mkThumbnail')){
    function mkThumbnail($src, $width = null, $height = null, $filename = null) {
        if (!isset($width) && !isset($height))
            return false;
        if (isset($width) && $width <= 0)
            return false;
        if (isset($height) && $height <= 0)
            return false;

        $size = getimagesize($src);
        if (!$size)
            return false;

        list($src_w, $src_h, $src_type) = $size;
        $src_mime = $size['mime'];
        switch($src_type) {
            case 1 :
                $img_type = 'gif';
                break;
            case 2 :
                $img_type = 'jpeg';
                break;
            case 3 :
                $img_type = 'png';
                break;
            case 15 :
                $img_type = 'wbmp';
                break;
            default :
                return false;
        }

        if ($src_w <= $src_h){
            $width = $src_w * ($height / $src_h);
        }elseif ($src_w >= $src_h){
            $height = $src_h * ($width / $src_w);
        }else{
            return true;
        }

        $imagecreatefunc = 'imagecreatefrom' . $img_type;
        $src_img = $imagecreatefunc($src);
        $dest_img = imagecreatetruecolor($width, $height);
        imagecopyresampled($dest_img, $src_img, 0, 0, 0, 0, $width, $height, $src_w, $src_h);

        $imagefunc = 'image' . $img_type;
        if ($filename) {
            $imagefunc($dest_img, $filename);
        } else {
            header('Content-Type: ' . $src_mime);
            $imagefunc($dest_img);
        }
        imagedestroy($src_img);
        imagedestroy($dest_img);
        return true;
    }
}