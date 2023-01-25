<?php
/**
 * Created by PhpStorm.
 * User: valor
 * Date: 2020/5/12
 * Time: 17:34
 */

namespace app\entities;
defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class Plugin extends BaseEntity
{
  protected $table = 'plugin';
}