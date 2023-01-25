<?php
/**
 * Created by PhpStorm.
 * User: leo_sung
 * Date: 2018/7/18
 * Time: 14:57
 */

namespace app\models;

use yii\base\Model;
use yii\web\UploadedFile;

/**
 * Class UploadForm
 * @property UploadedFile $up_image
 * @property UploadedFile $up_video
 * @package app\models
 */
class UploadBolb extends Model
{
    public $errMsg;
    public $original_name;
    public $new_file_name;

    public $up_image;
    public $up_image_save_path;     

    public $up_video;

    const ALLOWED_IMAGE_MIMETYPES = 'image/jpeg,image/png';
    public static $ALLOWED_IMAGE_EXTENSION_ARR = [".png",".jpg",".jpeg",".gif",".bmp"];


    public function rules()
    {
        return [
            [['up_image'],'file','mimeTypes' => self::ALLOWED_IMAGE_MIMETYPES],
        ];
    }
    

    public function attributeLabels()
    {
        return [
            'up_image'  => 'image',
        ];
    }

    /**
     * 
     */
    public function uploadSingleImg($base_path = 'image')
    {
        if($this->validate()){
            $this->original_name = $this->up_image->baseName;
            $dir = 'uploads/'.$base_path.'/';
            if(!file_exists($dir)){
                mkdir($dir,755,true);
            }
            $this->new_file_name = hw_unique().'.jpg';
            $this->up_image_save_path = $dir . $this->new_file_name;
            $upResult = $this->up_image->saveAs($this->up_image_save_path);
            if (!$upResult) {
                $this->errMsg = $this->codeToMessage($this->up_image->error);
            }
            return $upResult;
        }else{
            $errors = array_shift($this->errors);
            if(is_array($errors)){
                $this->errMsg = array_shift($errors);
            }
            return false;
        }
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
        $size = $info[1];
        $suffix = strtoupper($info[2]);
        $a = array_flip(array("B", "KB", "MB", "GB", "TB", "PB"));
        $b = array_flip(array("B", "K", "M", "G", "T", "P"));
        $pos = array_key_exists($suffix,$a)  ? $a[$suffix] : $b[$suffix];
        return round($size * pow(1024, $pos), $dec);
    }

    private static function get_post_max_filesize_byte($dec = 2)
    {
        $max_size = ini_get('post_max_size');
        preg_match('/(^[0-9\.]+)(\w+)/', $max_size, $info);
        $size = $info[1];
        $suffix = strtoupper($info[2]);
        $a = array_flip(array("B", "KB", "MB", "GB", "TB", "PB"));
        $b = array_flip(array("B", "K", "M", "G", "T", "P"));
        $pos = array_key_exists($suffix,$a) ? $a[$suffix] : $b[$suffix];
        return round($size * pow(1024, $pos), $dec);
    }


}