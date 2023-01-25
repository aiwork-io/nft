<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/7/18
 * Time: 14:57
 */

namespace app\models;

use yii\base\Model;
use yii\web\UploadedFile;

/**
 * Class UploadForm
 *
 * @property UploadedFile $up_image
 * @property UploadedFile $up_video
 * @package app\models
 */
class UploadForm extends Model
{
    public $errMsg;
    public $original_name;
    public $new_file_name;

    public $up_image;
    public $up_image_save_path;     //file path

    public $up_video;

    const ALLOWED_IMAGE_EXTENSION = 'png,jpg,jpeg,gif,bmp';
    public static $ALLOWED_IMAGE_EXTENSION_ARR = [".png", ".jpg", ".jpeg", ".gif", ".bmp"];


    public function rules()
    {
        $max = self::getMaxUploadSize();

        return [
            [['up_image'], 'image', 'extensions' => self::ALLOWED_IMAGE_EXTENSION],
            [['up_image'], 'image', 'maxSize' => $max * 1024 * 1024, 'message' => "图片大小限制为{$max}M"],
        ];
    }


    public function attributeLabels()
    {
        return [
            'up_image' => '图片',
        ];
    }

    /**
     * 单文件上传
     */
    public function uploadSingleImg($base_path = 'image')
    {
        $exting = str_replace("/", ".", $this->up_image->type);
        if (stripos($exting, 'quicktime') !== false) {
            $exting = str_replace("quicktime", "mp4", $exting);
        }

        $ext                 = strtolower(pathinfo($exting, PATHINFO_EXTENSION));
        $this->original_name = $this->up_image->baseName;
        $dir                 = 'uploads/' . $base_path . '/' . date('Y-m-d') . '/';
        if (!file_exists($dir)) {
            mkdir($dir, 755, true);
        }
        $this->new_file_name      = hw_unique() . '.' . $ext;
        $this->up_image_save_path = $dir . $this->new_file_name;
        $upResult                 = $this->up_image->saveAs($this->up_image_save_path);
        if (!$upResult) {
            $this->errMsg = $this->codeToMessage($this->up_image->error);
        }

        return $upResult;

    }

    public static function getMaxUploadSize()
    {
        $upload_max_size = self::get_upload_max_filesize_byte();
        $upload_max_size = intval($upload_max_size / (1024 * 1024));

        $post_max_size = self::get_post_max_filesize_byte();
        $post_max_size = intval($post_max_size / (1024 * 1024));

        return min($upload_max_size, 50, $post_max_size);
    }

    private static function get_upload_max_filesize_byte($dec = 2)
    {
        $max_size = ini_get('upload_max_filesize');
        preg_match('/(^[0-9\.]+)(\w+)/', $max_size, $info);
        $size   = $info[1];
        $suffix = strtoupper($info[2]);
        $a      = array_flip(["B", "KB", "MB", "GB", "TB", "PB"]);
        $b      = array_flip(["B", "K", "M", "G", "T", "P"]);
        $pos    = array_key_exists($suffix, $a) ? $a[$suffix] : $b[$suffix];

        return round($size * pow(1024, $pos), $dec);
    }

    private static function get_post_max_filesize_byte($dec = 2)
    {
        $max_size = ini_get('post_max_size');
        preg_match('/(^[0-9\.]+)(\w+)/', $max_size, $info);
        $size   = $info[1];
        $suffix = strtoupper($info[2]);
        $a      = array_flip(["B", "KB", "MB", "GB", "TB", "PB"]);
        $b      = array_flip(["B", "K", "M", "G", "T", "P"]);
        $pos    = array_key_exists($suffix, $a) ? $a[$suffix] : $b[$suffix];

        return round($size * pow(1024, $pos), $dec);
    }


}