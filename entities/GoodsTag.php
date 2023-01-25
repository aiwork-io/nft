<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/9/13
 * Time: 11:33
 */

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class GoodsTag extends BaseEntity
{
    protected $table = 'goods_tag';
}