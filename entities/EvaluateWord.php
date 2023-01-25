<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class EvaluateWord extends BaseEntity
{
    protected $table = 'evaluate_word';
    protected $guarded = [];

    public function evaluate_shops(){
        return $this->hasMany('app\entities\EvaluateShops', 'evaluate_word_id', 'id');
    }

}