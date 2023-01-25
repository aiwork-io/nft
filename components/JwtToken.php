<?php

namespace app\components;

use DateTimeImmutable;
use yii\base\Component;
use Lcobucci\JWT\Builder;
use Lcobucci\JWT\Signer\Key;
use Lcobucci\JWT\Signer\Hmac\Sha256;
use Lcobucci\JWT\Parser;
use yii\log\Logger;
class JwtToken extends Component
{
    public static function shengchengtoken($arr, $key, $t = 604800)
    {
        $signer = new Sha256();
        $time = time();
        do{
            $token = (new Builder())->expiresAt(new DateTimeImmutable(date('Y-m-d H:i:s',$time + $t)))->withClaim('user_infor', $arr)->getToken($signer, new Key($key));
            $data = explode('.', $token);
        } while (count($data) != 3);
        return (string)$token;
    }

    public static function yanzhengtoken($t, $key)
    {
        $token = (new Parser())->parse($t);
        //token
        $signer = new Sha256();//Generate JWT Token
        if (!$token->verify($signer, new Key($key))) {
            return false;
        }
        $tr = $token->getClaim('user_infor');
        return $tr;
    }


}