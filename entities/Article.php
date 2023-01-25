<?php

namespace app\entities;

defined('SITE_ROTE_TAG') OR (http_response_code(404) && exit(0));

class Article extends BaseEntity
{
    protected $table = 'article';
    protected $guarded = [];
    public function article_type()
    {
        return $this->belongsTo('app\entities\ArticleType');
    }

}