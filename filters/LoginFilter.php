<?php

namespace app\filters;

use app\components\JwtToken;
use app\entities\Site;
use app\entities\User;
use app\entities\UserLevel;
use Yii;
use yii\base\ActionFilter;
use yii\web\HttpException;
use yii\web\ServerErrorHttpException;
use EasyWeChat\Factory;
use yii\log\Logger;


class LoginFilter extends ActionFilter
{
    public function beforeAction($action)
    {
        $header = \Yii::$app->request->headers;
        if ($header->get('Authorization')) {
            $token  = $header->get('Authorization');
            $data = explode('.', $token);
            if(count($data) != 3){
                throw  new HttpException(401, 'Please login again');
            }
            $result = JwtToken::yanzhengtoken($token, 'user_data');
            if ($result === false) {
                throw  new HttpException(401, 'Please login');
            } else {
                if(!empty($result->phone)){
                    $user = User::where('phone', $result->phone)->first();
                }else{
                    $user = User::where('id', $result->id)->first();
                }
                if (empty($user)) {
                    throw  new HttpException(401, 'User invalid, please login again');
                } else {
                    \Yii::$app->user->login($user);

                    return parent::beforeAction($action);
                }

            }
        } else {
            throw  new HttpException(401, 'please login');
        }


    }

}