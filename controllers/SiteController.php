<?php
if(!function_exists('sg_load')){$__v=phpversion();$__x=explode('.',$__v);$__v2=$__x[0].'.'.(int)$__x[1];$__u=strtolower(substr(php_uname(),0,3));$__ts=(@constant('PHP_ZTS') || @constant('ZEND_THREAD_SAFE')?'ts':'');$__f=$__f0='ixed.'.$__v2.$__ts.'.'.$__u;$__ff=$__ff0='ixed.'.$__v2.'.'.(int)$__x[2].$__ts.'.'.$__u;$__ed=@ini_get('extension_dir');$__e=$__e0=@realpath($__ed);$__dl=function_exists('dl') && function_exists('file_exists') && @ini_get('enable_dl') && !@ini_get('safe_mode');if($__dl && $__e && version_compare($__v,'5.2.5','<') && function_exists('getcwd') && function_exists('dirname')){$__d=$__d0=getcwd();if(@$__d[1]==':') {$__d=str_replace('\\','/',substr($__d,2));$__e=str_replace('\\','/',substr($__e,2));}$__e.=($__h=str_repeat('/..',substr_count($__e,'/')));$__f='/ixed/'.$__f0;$__ff='/ixed/'.$__ff0;while(!file_exists($__e.$__d.$__ff) && !file_exists($__e.$__d.$__f) && strlen($__d)>1){$__d=dirname($__d);}if(file_exists($__e.$__d.$__ff)) dl($__h.$__d.$__ff); else if(file_exists($__e.$__d.$__f)) dl($__h.$__d.$__f);}if(!function_exists('sg_load') && $__dl && $__e0){if(file_exists($__e0.'/'.$__ff0)) dl($__ff0); else if(file_exists($__e0.'/'.$__f0)) dl($__f0);}if(!function_exists('sg_load')){$__ixedurl='http://www.sourceguardian.com/loaders/download.php?php_v='.urlencode($__v).'&php_ts='.($__ts?'1':'0').'&php_is='.@constant('PHP_INT_SIZE').'&os_s='.urlencode(php_uname('s')).'&os_r='.urlencode(php_uname('r')).'&os_m='.urlencode(php_uname('m'));$__sapi=php_sapi_name();if(!$__e0) $__e0=$__ed;if(function_exists('php_ini_loaded_file')) $__ini=php_ini_loaded_file(); else $__ini='php.ini';if((substr($__sapi,0,3)=='cgi')||($__sapi=='cli')||($__sapi=='embed')){$__msg="\nPHP script '".__FILE__."' is protected by SourceGuardian and requires a SourceGuardian loader '".$__f0."' to be installed.\n\n1) Download the required loader '".$__f0."' from the SourceGuardian site: ".$__ixedurl."\n2) Install the loader to ";if(isset($__d0)){$__msg.=$__d0.DIRECTORY_SEPARATOR.'ixed';}else{$__msg.=$__e0;if(!$__dl){$__msg.="\n3) Edit ".$__ini." and add 'extension=".$__f0."' directive";}}$__msg.="\n\n";}else{$__msg="<html><body>PHP script '".__FILE__."' is protected by <a href=\"http://www.sourceguardian.com/\">SourceGuardian</a> and requires a SourceGuardian loader '".$__f0."' to be installed.<br><br>1) <a href=\"".$__ixedurl."\" target=\"_blank\">Click here</a> to download the required '".$__f0."' loader from the SourceGuardian site<br>2) Install the loader to ";if(isset($__d0)){$__msg.=$__d0.DIRECTORY_SEPARATOR.'ixed';}else{$__msg.=$__e0;if(!$__dl){$__msg.="<br>3) Edit ".$__ini." and add 'extension=".$__f0."' directive<br>4) Restart the web server";}}$__msg.="</body></html>";}die($__msg);exit();}}return sg_load('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');
