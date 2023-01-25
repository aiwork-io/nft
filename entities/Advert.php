<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/18
 * Time: 7:36
 *
*/
class Advert extends BaseEntity
{
    protected $table = 'advert';
    
    public function getImagesAttribute($images)
    {
        if (empty($images)) {
            return [];
        }else{
            return json_decode($images,true);
        }
    }

    /**
     * @param $data
     *
     * @return mixed
     */
    public function setImagesAttribute($data)
    {
        if (empty($data) || !is_array($data)) {
            return $this->attributes['images'] = '';
        }
        $data = array_filter($data);

        $this->attributes['images'] = json_encode($data);
    }
}