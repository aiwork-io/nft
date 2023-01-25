<?php
/**
 * Created by PhpStorm.
 * User: leo_sung
 * Date: 2018/9/25
 * Time: 9:41
 */

namespace app\helpers;

/**
 * Image compression
 */
class ImageCompress
{

    private $src;
    private $image;
    private $imageinfo;
    private $percent = 0.5;

    /**
     * Image compression
     *
     * @param       $src     string
     * @param float $percent compression ratio
     */
    public function __construct($src, $percent = 1)
    {
        $this->src     = $src;
        $this->percent = $percent;
    }


    /** High resolution image
     *
     * @param string $saveName 
     */
    public function compress($saveName = '')
    {
        $this->_openImage();
        if (!empty($saveName)) $this->_saveImage($saveName);  //保存
        else $this->_showImage();
    }

    /**
     * 
     */
    private function _openImage()
    {
        list($width, $height, $type, $attr) = getimagesize($this->src);
        $this->imageinfo = [
            'width'  => $width,
            'height' => $height,
            'type'   => image_type_to_extension($type, false),
            'attr'   => $attr,
        ];
        $fun             = "imagecreatefrom" . $this->imageinfo['type'];
        $this->image     = @$fun($this->src);
        if ($this->image == false){var_dump($this->src);die;}
            $this->_thumpImage();
    }

    /**
     * 
     */
    private function _thumpImage()
    {
        $new_width   = $this->imageinfo['width'] * $this->percent;
        $new_height  = $this->imageinfo['height'] * $this->percent;
        $image_thump = imagecreatetruecolor($new_width, $new_height);
        
        imagecopyresampled($image_thump, $this->image, 0, 0, 0, 0, $new_width, $new_height, $this->imageinfo['width'], $this->imageinfo['height']);
        imagedestroy($this->image);
        $this->image = $image_thump;
    }

    /**
     * 
     */
    private function _showImage()
    {
        header('Content-Type: image/' . $this->imageinfo['type']);
        $funcs = "image" . $this->imageinfo['type'];
        $funcs($this->image);
    }

    /**
     * Save image to disk
     *
     * @param  string $dstImgName 1、
     */
    private function _saveImage($dstImgName)
    {
        if (empty($dstImgName)) return false;
        $allowImgs = ['.jpg', '.jpeg', '.png', '.bmp', '.wbmp', '.gif'];   //
        $dstExt    = strrchr($dstImgName, ".");
        $sourseExt = strrchr($this->src, ".");
        if (!empty($dstExt)) $dstExt = strtolower($dstExt);
        if (!empty($sourseExt)) $sourseExt = strtolower($sourseExt);

      
        if (!empty($dstExt) && in_array($dstExt, $allowImgs)) {
            $dstName = $dstImgName;
        } else if (!empty($sourseExt) && in_array($sourseExt, $allowImgs)) {
            $dstName = $dstImgName . $sourseExt;
        } else {
            $dstName = $dstImgName . $this->imageinfo['type'];
        }
        $funcs = "image" . $this->imageinfo['type'];
        $funcs($this->image, $dstName);
    }

    /**
     * delete image
     */
    public function __destruct()
    {
        if(!is_null($this->image)){
            imagedestroy($this->image);
        }

    }


}