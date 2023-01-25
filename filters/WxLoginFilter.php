<?php

namespace app\filters;

use app\entities\Site;
use app\entities\User;
use app\entities\UserLevel;
use Yii;
use yii\base\ActionFilter;
use yii\web\ServerErrorHttpException;
use EasyWeChat\Factory;
use yii\log\Logger;
use app\components\OpenRedis;


class WxLoginFilter extends ActionFilter
{
    public function beforeAction($action)
    {
        //$current_url   = \Yii::$app->request->absoluteUrl;
        //$doc_url = mb_substr($current_url, 0, mb_stripos($current_url, 'index.php'));
        $q = \Yii::$app->request->get('q');
        if ($q != 'xcx') {
            $sid  = (int)\Yii::$app->request->get('sid', 0);
            $site = Site::find($sid);

            if (empty($site) || empty($site->appid) || empty($site->appsecret)) {
                if (empty($site)) {
                    throw new ServerErrorHttpException('Please set appid and appsecret');
                }
            }
            $current_url = \Yii::$app->request->absoluteUrl;
            $options     = [
                'app_id' => $site->appid,
                'secret' => $site->appsecret,
                'oauth'  => [
                    'scopes'   => ['snsapi_userinfo'],
                    'callback' => $current_url,
                ],
            ];
            $app         = Factory::officialAccount($options);
            //\Yii::$app->getSession()->destroy();
            if (Yii::$app->user->isGuest) {
                $code         = \Yii::$app->request->get('code');
                $recommend_id = \Yii::$app->request->get('recommend_id');
                if (is_null($code)) {
                    $response = $app->oauth->scopes(['snsapi_userinfo'])->redirect();
                    $response->send();
                    exit;
                } else {
                 
                    if (isset($recommend_id) && !empty($recommend_id)) {
                        $recommend_people = User::whereId($recommend_id)->first();
                        if (!empty($recommend_people)) {
                            $parent_id = $parent_id = $recommend_id;
                        } else {
                            $parent_id = 0;
                        }
                    } else {
                        $parent_id = 0;
                    }
                    $oauth = $app->oauth;
                    try {
                        $user  = $oauth->user();
                    } catch (\Exception $e) {
                        $response = $app->oauth->scopes(['snsapi_userinfo'])->redirect();
                        $response->send();
                        exit;
                    }

                    $this->authenticateWithWechatData($user['original'], $parent_id,$sid);
                }
            } else {

                $mini_id = \Yii::$app->request->get('mini_id');
                $user = \Yii::$app->user->identity;
                //da($user);
                if (!empty($mini_id)) {
                    $user->mini_openid = $mini_id;
                    $user->save();
                }
                if ($user->activity_new_user == 2 || $user->site_id!=$sid) {
                    $code         = \Yii::$app->request->get('code');
                    $recommend_id = \Yii::$app->request->get('recommend_id');
                    if (is_null($code)) {
                        $response = $app->oauth->scopes(['snsapi_userinfo'])->redirect();
                        $response->send();
                        exit;
                    } else {
                        //判断是否有推荐人id
                        if (isset($recommend_id) && !empty($recommend_id)) {
                            $recommend_people = User::whereId($recommend_id)->first();
                            if (!empty($recommend_people)) {
                                $parent_id = $parent_id = $recommend_id;
                            } else {
                                $parent_id = 0;
                            }
                        } else {
                            $parent_id = 0;
                        }
                        $oauth = $app->oauth;
                        try {
                            $user = $oauth->user();
                        } catch (\Exception $e) {
                            $response = $app->oauth->scopes(['snsapi_userinfo'])->redirect();
                            $response->send();
                            exit;
                        }

                        $this->authenticateWithWechatData($user['original'], $parent_id,$sid);
                    }
                }

            }
        }
        if ($user['forzen'] == 2) {
            echo "<script>location.href='?r=home/user/out-to&sid=" . $sid . "';</script>";
            exit;
        }

        return parent::beforeAction($action);
    }

    public function authenticateWithWechatData($user, $parent_id,$sid)
    {
        $socialite_builder = User::where('site_id',$sid)->whereOpenid($user['openid']);
        if ($socialite_builder->exists()) {
            $user_exists            = $socialite_builder->first();
            $user_exists->nick_name = $user['nickname'];
            $user_exists->avatar    = $user['headimgurl'];
            $user_exists->activity_new_user = 1;
            $user_exists->save();
            Yii::$app->user->login($user_exists);
        } else {
            $this->register($user, $parent_id);
        }

    }

    public function register($user, $parent_id)
    {
        $sid          = (int)\Yii::$app->request->get('sid', 0);
        $mini_id      = \Yii::$app->request->get('mini_id');
        $defaultLevel = UserLevel::where('site_id', $sid)->where('is_default', 1)->first();

        $user_new             = new User();
        $user_new->openid     = $user['openid'];
        $user_new->nick_name  = $user['nickname'];
        $user_new->avatar     = $user['headimgurl'];
        $user_new->site_id    = $sid;
        $user_new->level      = $defaultLevel->id;
        $user_new->province   = "";
        $user_new->city       = "";
        $user_new->district   = "";
        $user_new->address    = "";
        $user_new->s_name     = "";
        $user_new->s_phone    = "";
        $user_new->s_province = "";
        $user_new->s_city     = "";
        $user_new->s_district = "";
        $user_new->s_address  = "";
        $user_new->parent_id  = $parent_id;
     
        $user_new->activity_new_user = 1;

        if (!empty($mini_id)) {
            $user_new->mini_openid = $mini_id;
        } else {
            $user_new->mini_openid = '';
        }
        $user_new->save();
        Yii::$app->user->login($user_new);
    }

}