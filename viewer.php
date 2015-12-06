<?php

function tpl_display($tpl_name = 'html', $data = array()) {
    $viewer = tpl_get_viewer();
    $viewer->assign($data);
    $viewer->display($tpl_name . '.tpl');
}



function tpl_get_viewer($dir_base = '') {
    if (!$dir_base) {
        $dir_base   = rtrim(realpath(dirname(__FILE__)), '\\/') . '/';
    }
    $dir_views      = $dir_base     . '';
    $dir_smarty     = $dir_base     . '../smarty-3.1.16/libs/';
    require_once($dir_smarty        . 'Smarty.class.php');

    $smarty = new Smarty;
    $smarty->setTemplateDir($dir_views  . 'templates/');
    $smarty->setCompileDir($dir_views   . '../templates_c/');
    $smarty->left_delimiter     = '{%';
    $smarty->right_delimiter    = '%}';

    $smarty->registerFilter('pre', 'tpl_filter_pre');
    return $smarty;
}



function tpl_filter_pre($tpl_source) {
    $tpl_source = preg_replace('/[\t ]*[\r\n]+[\t ]*/', "\n", $tpl_source);
    $tpl_source = preg_replace_callback(
        '/\n<style (data-attr="style")?>\n([\s\S]*?)\n<\/style>\n/',
        function ($matches) {
            $style  = preg_replace('/\n\/\*[\s\S]*?\*\/\s*|\s*\/\*[\s\S]*?\*\/\n/', '', $matches[2]);
            $style  = preg_replace('/\n/', '', $style);
            if ($matches[1]) {
                return '<style>' . $style . '</style>';
            }
            return $style;
        },
        $tpl_source
    );
    $tpl_source = preg_replace_callback(
        '/\n<script (data-attr="script")?>\n([\s\S]*?)\n<\/script>\n/',
        function ($matches) {
            $lines  = explode("\n", $matches[2]);
            foreach ($lines as $index => $line) {
                $line   = preg_replace('/\s*\/\/[^\'"]*$/', '', $line);
                $lines[$index] = $line;
                if (strpos($line, '//') !== false) {
                    $lines[$index] = $line . "\n";
                }
            }
            if ($matches[1]) {
                $lines[0]   = '<script>' . $lines[0];
                $lines[]    = '</script>';
            }
            return implode('', $lines);
        },
        $tpl_source
    );
    return preg_replace('/([>}])[\n]([{<])/', '${1}${2}', $tpl_source);
}



function tpl_get_src_files($dist_list = array(), $src_json_file = '') {
    $src_files  = [];
    $dir_dist   = '';
    $dir_src    = '';
    ob_start();
        include $src_json_file;
        $src_json   = ob_get_contents();
    ob_end_clean();
    $src_json   = json_decode($src_json, true);
    foreach ($dist_list as $dist) {
        $match  = 0;
        foreach ($src_json as &$item) {
            if (substr($item['dist'], -1) === '/') {
                $dir_dist   = $item['dist'];
                $dir_src    = $item['srcs'][0];
                continue;
            }
            if ($dir_dist . $item['dist'] === $dist) {
                $match  = 1;
                foreach ($item['srcs'] as $src) {
                    $src_files[] = $dir_src . $src;
                }
            }
        }
        if (!$match) {
            $src_files[] = $dist;
        }
    }
    return $src_files;
}
