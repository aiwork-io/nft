<?php
/**
 * Created by PhpStorm.
 * User: howous
 * Date: 2018/9/22
 * Time: 18:27
 */

namespace app\filters;


use app\entities\OpenSet;
use app\entities\Site;
use yii\base\ActionFilter;
use yii\web\BadRequestHttpException;

class SiteFilter extends ActionFilter
{
    public function beforeAction($action)
    {
        $q = \Yii::$app->request->get('q');
        if ($q !== 'xcx') {
            $sid  = (int)\Yii::$app->request->get('sid', 0);
            $site = Site::find($sid);
            if (empty($site)) {
                throw new BadRequestHttpException('Path is incorrect or missing');
            }
        }

        return parent::beforeAction($action);
    }
}
