<?php

namespace app\components;

use yii\base\Component;
use OSS\Core\OssException;
use OSS\OssClient;

class Aliyunupload extends Component
{
    public $ossClient;

    public $accessKeyId;

    public $accessKeySecret;

    public $endpoint;

    public $bucket;

    public function __construct($config)
    {
        parent::__construct();
//        $accessKeyId     = 'LTAI4G2cYTKnUP5jYDZ6xdmL';                 //Get Aliyun oss的accessKeyId
//        $accessKeySecret = 'eXhCGU5Z0yX54ZB4dCxmO2y03K30aW';         //Get Aliyunoss的accessKeySecret
//        $endpoint        = 'oss-cn-shanghai.aliyuncs.com';//Get oss endPoint

        $this->accessKeyId     = $config['alioss_access_key_id'];
        $this->accessKeySecret = $config['alioss_access_key_secret'];
        $this->endpoint        = $config['alioss_endpoint'];
        $this->bucket          = $config['alioss_bucket'];
        $this->ossClient       = new OssClient($this->accessKeyId, $this->accessKeySecret, $this->endpoint);
    }

    /**
     * Use Aliyun oss uploader
     *
     * @param string object save file name
     * @param string filepath file path
     *
     * @return string     if upload is successful
     */
    public function upload($object, $filepath)
    {
        try {
            $exting = explode('.', $object);
            $ext    = end($exting);
            $object = date('Y-m-d') . '/' . time() . mt_rand() . '.' . $ext;
            $t      = $this->ossClient->uploadFile($this->bucket, $object, $filepath);
            $url    = $t['info']['url'];
        } catch (OssException $e) {
            $url = '';
        }

        return $url;
    }


    /**
     * delete file
     *
     * @param string object delete filename
     *
     * @return bool   Is deletion successful
     */
    public function delete($object)
    {
        if ($this->ossClient->deleteObject($this->bucket, $object)) {
            //Use deleteObject to send file to Aliyun
            $res = true;
        } else {
            $res = false;
        }

        return $res;
    }


}