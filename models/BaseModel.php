<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/7/28
 * Time: 16:11
 */

namespace app\models;
use Illuminate\Support\Arr;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));


/**
 * Class BaseModel
 *
 * @property array $modelSafeData
 * @package app\models
 */
class BaseModel extends \yii\base\Model
{
    protected $modelSafeData = [];

    public function verify()
    {
        $this->clearModelSafeData();
        if ($this->validate()) {
            $safeAttr = $this->safeAttributes();
            $safeData = [];
            foreach ($safeAttr as $attr) {
                $safeData[$attr] = $this->$attr;
            }
            $this->modelSafeData = $safeData;

            return true;
        } else {
            return $this->errors;
        }
    }

    public function firstErrorMsg()
    {
        if ($this->hasErrors()) {
            $firstArr = $this->firstErrors;
            return array_shift($firstArr);
        }

        return '';
    }

    protected function clearModelSafeData()
    {
        $this->modelSafeData = [];
    }

    public function getModelSafeData()
    {
        return $this->modelSafeData;
    }
}