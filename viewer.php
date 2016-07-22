<?php

function tpl_display($view = '', $vars = array()) {
    $dir_sep    = DIRECTORY_SEPARATOR;
    $dir_base   = __DIR__ . $dir_sep;
    $dir_smarty = $dir_base . implode($dir_sep, array('..', 'smarty-3.1.16', 'libs', ''));
    $dir_tpls   = $dir_base . 'tpls' . $dir_sep;
    $dir_tplc   = $dir_base . 'tplc' . $dir_sep;
    $dir_plgs   = $dir_base . 'plugins' . $dir_sep;

    require_once($dir_smarty . 'Smarty.class.php');
    $smarty = new Smarty;
    $smarty->left_delimiter = '<%';
    $smarty->right_delimiter = '%>';
    $smarty->setTemplateDir($dir_tpls);
    $smarty->setCompileDir($dir_tplc);
    $smarty->addPluginsDir($dir_plgs);
    $smarty->registerFilter('pre', 'tpl_pre_filter');

    if (isset($vars['debug'])) {
        $smarty->force_compile = true;
    }
    $smarty->assign($vars);
    $smarty->display($view . '.tpl');
    if (isset($vars['debug'])) {
        $smarty->clearCompiledTemplate();
    }
}



function tpl_pre_filter($tpl_source, Smarty_Internal_Template $template) {
    $debug  = isset($template->smarty->tpl_vars['debug']);
    $ldeli  = $template->smarty->left_delimiter;
    $rdeli  = $template->smarty->right_delimiter;
    $tpl_source = preg_replace('/[\t ]*[\r\n]+[\t ]*/', "\n", trim($tpl_source));
    $tpl_source = tpl_filter_style($tpl_source, function ($content, $matches) use ($ldeli, $rdeli) {
        return $ldeli . "capture append = 'tpa_" . $matches[2] . "'" . $rdeli .
                $content . $ldeli . '/capture' . $rdeli;
    }, $debug);
    return $debug ? $tpl_source : preg_replace('/>\n+</', '><', $tpl_source);
}



function tpl_filter_style($codes = '', $callback = null, $debug = false) {
    return preg_replace_callback(
        '/<(style|script) tpa="(\w*)"(.*?)>\n([\s\S]*?)\n<\/(?:style|script)>/',
        function ($matches) use ($callback, $debug) {
            $tob_type   = $matches[1];
            $tob_name   = $matches[2];
            $tob_pams   = $matches[3];
            $content    = $matches[4];
            if ($debug || strpos($tob_pams, 'debug') !== false) {
                // debug 模式
            } else if ($tob_type === 'style') {
                $content    = preg_replace('/\s*\/\*[\s\S]*?\*\/\s*/', '', $content);
                $content    = preg_replace('/\n/', '', $content);
            } else {
                $lines      = explode("\n", $content);
                foreach ($lines as $index => $line) {
                    $line   = preg_replace('/\s*\/\/[^\'"]*$/', '', $line);
                    $lines[$index] = $line . (strpos($line, '//') === false ? '' : "\n");
                }
                $content    = implode('', $lines);
            }
            if ($tob_name && is_callable($callback)) {
                $fcontent = $callback($content, $matches);
                return is_string($fcontent) ? $fcontent : $content;
            } else {
                return '<' . $tob_type . $tob_pams . '>' . $content . '</' . $tob_type . '>';
            }
        },
        $codes
    );
}
