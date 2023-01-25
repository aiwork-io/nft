<?php
namespace app\entities;
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/8/5
 * Time: 11:28
 */

use Carbon\Carbon;
use Illuminate\Database\Capsule\Manager;

class BaseEntity extends \Illuminate\Database\Eloquent\Model
{
    protected $guarded = [];

    public function __construct(array $attributes = array())
    {
        parent::__construct($attributes);
        $this->init();
        Carbon::setLocale('zh');
    }

    // initialize
    public function init()
    {
        static $capsule = null;
        if (!$capsule) {
            $capsule = new Manager();

            $dbConfig = require  \Yii::getAlias('@app/config/database.php');
            $capsule->addConnection($dbConfig);
            $capsule->setAsGlobal();
            $capsule->bootEloquent();
        }
        // return $capsule;
    }

    public static function className()
    {
        return get_called_class();
    }

}