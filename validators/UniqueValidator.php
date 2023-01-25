<?php

namespace app\validators;
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

use yii\base\InvalidConfigException;
use yii\validators\Validator;

/**
 * Class UniqueValidator
 *
 * @package app\validators
 */
class UniqueValidator extends Validator
{
    public $targetClass;

    public $targetAttribute;

    public $filter;

    public $message;


    public $targetAttributeJunction = 'and';



    /**
     * {@inheritdoc}
     */
    public function init()
    {
        parent::init();
        if ($this->message === null) {
            $this->message = '数据必需唯一';
        }
    }

    /**
     * {@inheritdoc}
     */
    public function validateAttribute($model, $attribute)
    {
        if(is_null($this->targetClass)){
            throw new InvalidConfigException('The "targetClass" property must be configured as a string.');
        }

        $targetAttribute = $this->targetAttribute === null ? $attribute : $this->targetAttribute;

        $conditions = [$this->targetAttributeJunction === 'or' ? 'or' : 'and'];

        $targetClass  = new $this->targetClass;
        $query = $this->prepareQuery($targetClass,$conditions);

        if(!$this->checkUnique($query,$targetAttribute,$model->$attribute)){
            $this->addError($model, $attribute, $this->message);
        }
    }


    /**
     * Prepares a query by applying filtering conditions defined in $conditions method property
     * and [[filter]] class property.
     *
     * @param \Illuminate\Database\Eloquent\Model $targetClass the name of the ActiveRecord class that should be used to validate
     * the uniqueness of the current attribute value.
     * @param array $conditions conditions, compatible with [[\yii\db\Query::where()|Query::where()]] key-value format
     *
     * @return \Illuminate\Database\Eloquent\Model
     */
    private function prepareQuery($targetClass, $condition)
    {
        $query = $targetClass;
        if ($this->filter instanceof \Closure) {
            call_user_func($this->filter, $query);
        } elseif (!empty($this->filter) && is_array($this->filter)) {
            $method = 'where';
            if($condition == 'or'){
                $method = 'orWhere';
            }

            foreach ($this->filter as $item){
                if(count($item) === 3){
                    $query = $query->$method($item[0],$item[1],$item[2]);
                }else{
                    $query = $query->$method($item[0],$item[1]);
                }
            }
        }
        return $query;
    }

    /**
     * @param \Illuminate\Database\Eloquent\Model $query
     */
    private function checkUnique($query,$field,$value)
    {
        return !$query->where($field,$value)->exists();
    }
}
