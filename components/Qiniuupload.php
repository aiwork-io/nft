<?php

namespace app\components;

use Qiniu\Auth;
use Qiniu\Storage\UploadManager;
use yii\base\Component;
use OSS\Core\OssException;
use OSS\OssClient;

class Qiniuupload extends Component
{
    public $ossClient;

    public $accessKey;

    public $secretKey;

    public $bucket;

    public $domain;

    public $auth;

    public function __construct($config)
    {
        parent::__construct();
        $this->accessKey = $config['qnoss_access_key'];
        $this->secretKey = $config['qnoss_secret_key'];
        $this->bucket    = $config['qnoss_bucket'];
        $this->domain    = $config['qnoss_domain'];
        $this->auth      = new Auth($this->accessKey, $this->secretKey);
    }

    /**
     * oss uploader
     *
     * @param string object 
     * @param string filepath 
     *
     * @return string     Upload success
     */
    public function upload($objectName, $filePath)
    {
        $exting     = explode('.', $objectName);
        $ext        = end($exting);
        $objectName = date('Y-m-d') . '/' . time() . mt_rand() . '.' . $ext;
        $token      = $this->auth->uploadToken($this->bucket);
        $uploadMgr  = new UploadManager();
        list($result, $error) = $uploadMgr->putFile($token, $objectName, $filePath);
        if ($error !== null) {
            return '';
        } else {
            return $this->domain . '/' . $result['key'];
        }
    }


}