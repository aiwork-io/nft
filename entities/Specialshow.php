<?php

namespace app\entities;
defined('SITE_ROTE_TAG') or (http_response_code(404) && exit(0));

class Specialshow extends \Illuminate\Database\Eloquent\Model
{
    protected $table = 'special_show';
    protected $guarded = [];
    
    public function goods()
    {
        return $this->hasMany('app\entities\Goods', 'special_show_id', 'id')->orderBy('order','desc')->where('issale',1)->whereIn('status',['-1','-2','1']);
    }

    


}