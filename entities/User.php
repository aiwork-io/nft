<?php

namespace app\entities;

use yii\web\IdentityInterface;

class User extends \Illuminate\Database\Eloquent\Model implements IdentityInterface
{
    protected $table = 'user';
    protected $guarded = [];

    const VERIFY_STATUS_BLANK = 0;
    const VERIFY_STATUS_NEED_VERIFY = 1;
    const VERIFY_STATUS_THROUGH = 4;
    const VERIFY_STATUS_RETURN = 3;

    public static $verify_status = [
        self::VERIFY_STATUS_BLANK       => '待完善',
        self::VERIFY_STATUS_NEED_VERIFY => '待审核',
        self::VERIFY_STATUS_THROUGH     => '审核通过',
        self::VERIFY_STATUS_RETURN      => '审核未通过',
    ];

    public function setNickNameAttribute($data)
    {
        if (empty($data)) {
            $this->attributes['nick_name'] = '';
        }
        $this->attributes['nick_name'] = preg_replace_callback(
            '/./u',
            function (array $match) {
                return strlen($match[0]) >= 4 ? '' : $match[0];
            },
            $data);
    }
    public function parentId()
    {
        return $this->hasOne('app\entities\User','id', 'parent_id');
    }

    public function goods()
    {
        return $this->hasMany('app\entities\Goods');
    }

    public function priceOffer()
    {
        return $this->hasMany('app\entities\PriceOffer');
    }

    public function userLevel()
    {
        return $this->hasOne('app\entities\UserLevel', 'id', 'level');
    }

    public function shop()
    {
        return $this->hasOne('app\entities\Shops', 'user_id', 'id');
    }

    public function sons()
    {
        return $this->hasMany('app\entities\User','parent_id', 'id');
    }


    public function integral()
    {
        return $this->hasOne('app\entities\UserIntegral', 'user_id', 'id');
    }

    /**
     * 根据给到的ID查询身份。
     *
     * @param string|integer $id 被查询的ID
     *
     * @return IdentityInterface|null 通过ID匹配到的身份对象
     */
    public static function findIdentity($id)
    {
        return self::find($id);
    }

    /**
     * 根据 token 查询身份。
     *
     * @param string $token 被查询的 token
     *
     * @return IdentityInterface|null 通过 token 得到的身份对象
     */
    public static function findIdentityByAccessToken($token, $type = null)
    {
        return self::find(['access_token' => $token]);
    }

    /**
     * @return int|string 当前用户ID
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return string 当前用户的（cookie）认证密钥
     */
    public function getAuthKey()
    {
        return $this->auth_key;
    }

    /**
     * @param string $authKey
     *
     * @return boolean if auth key is valid for current user
     */
    public function validateAuthKey($authKey)
    {
        return $this->getAuthKey() === $authKey;
    }
}