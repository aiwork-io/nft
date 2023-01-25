<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace app\validators;
defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

use yii\base\InvalidConfigException;
use yii\validators\Validator;

/**
 * ExistValidator validates that the attribute value exists in a table.
 *
 * @since 2.0
 */
class ExistValidator extends Validator
{
    /**
     * @var string the name of the ActiveRecord class that should be used to validate the existence
     * of the current attribute value. If not set, it will use the ActiveRecord class of the attribute being validated.
     * @see targetAttribute
     */
    public $targetClass;
    /**
     * @var string|array the name of the ActiveRecord attribute that should be used to
     * validate the existence of the current attribute value. If not set, it will use the name
     * of the attribute currently being validated. You may use an array to validate the existence
     * of multiple columns at the same time. The array key is the name of the attribute with the value to validate,
     * the array value is the name of the database field to search.
     */
    public $targetAttribute;
    /**
     * @var string|array|\Closure additional filter to be applied to the DB query used to check the existence of the attribute value.
     * This can be a string or an array representing the additional query condition (refer to [[\yii\db\Query::where()]]
     * on the format of query condition), or an anonymous function with the signature `function ($query)`, where `$query`
     * is the [[\yii\db\Query|Query]] object that you can modify in the function.
     */
    public $filter;
    /**
     * @var bool whether to allow array type attribute.
     */
//    public $allowArray = false;
    /**
     * @var string and|or define how target attributes are related
     * @since 2.0.11
     */
    public $targetAttributeJunction = 'and';


    /**
     * {@inheritdoc}
     */
    public function init()
    {
        parent::init();
        if ($this->message === null) {
            $this->message = '数据不存在';
        }
    }

    /**
     * {@inheritdoc}
     */
    public function validateAttribute($model, $attribute)
    {
        $this->checkTargetAttributeExistence($model, $attribute);
    }


    /**
     * Validates existence of the current attribute based on targetAttribute
     * @param \yii\base\Model $model the data model to be validated
     * @param string $attribute the name of the attribute to be validated.
     */
    private function checkTargetAttributeExistence($model, $attribute)
    {
        $targetAttribute = $this->targetAttribute === null ? $attribute : $this->targetAttribute;

//        $params = $this->prepareConditions($targetAttribute, $model, $attribute);
        $conditions = [$this->targetAttributeJunction == 'or' ? 'or' : 'and'];

        if (is_null($this->targetClass)) {
            throw new InvalidConfigException('The "targetClass" property must be configured as a string.');
        }

        $targetClass = new $this->targetClass;

        $query = $this->createQuery($targetClass, $conditions);
        if (!$this->valueExists($query, $targetAttribute, $model->$attribute)) {
            $this->addError($model, $attribute, $this->message);
        }
    }



    /**
     * {@inheritdoc}
     */
    protected function validateValue($value)
    {
        if ($this->targetClass === null) {
            throw new InvalidConfigException('The "targetClass" property must be set.');
        }
        if (!is_string($this->targetAttribute)) {
            throw new InvalidConfigException('The "targetAttribute" property must be configured as a string.');
        }

        if (is_array($value) && !$this->allowArray) {
            return [$this->message, []];
        }

        $query = $this->createQuery($this->targetClass, [$this->targetAttribute => $value]);

        return $this->valueExists($this->targetClass, $query, $value) ? null : [$this->message, []];
    }

    /**
     * Check whether value exists in target table
     *
     * @param \Illuminate\Database\Eloquent\Model $targetClass
     * @param string $query
     * @param mixed $value the value want to be checked
     * @return bool
     */
    private function valueExists($query, $targetAttribute, $value)
    {
        $exists = $query->where($targetAttribute,$value)->exists();

        return $exists;
    }



    /**
     * Creates a query instance with the given condition.
     * @param string $targetClass the target AR class
     * @param mixed $condition query condition
     * @return \Illuminate\Database\Eloquent\Model the query instance
     */
    protected function createQuery($targetClass, $condition)
    {
        /* @var $targetClass \Illuminate\Database\Eloquent\Model */
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

}
