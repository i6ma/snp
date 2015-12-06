<!doctype html>
<html lang="zh-CN">
    {%$tpa_css          = []%}
    {%$tpa_js           = []%}
    {%$tpa_style        = []%}
    {%$tpa_script       = []%}

    {%$tpa_css[]        = 'css/style.css'%}
    {%$tpa_js[]         = 'js/script.js'%}



    {%capture   'head'%}
        {%block 'head'%}
            <script data-attr="script">
                // time first
                var time_adjustment = new Date - {%$smarty.now * 1000%};
            </script>
        {%/block%}
    {%/capture%}

    {%capture   'body'%}
        {%block 'body'%}{%/block%}
    {%/capture%}



    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <title>{%$tpv_title%}</title>

        {%$smarty.capture.head%}

        {%if $IS_DEV%}
            {%$tpa_css  = tpl_get_src_files($tpa_css, 'css_src/gulp.json')%}
        {%/if%}
        {%foreach $tpa_css as $item%}
            <link rel="stylesheet" type="text/css" href="{%$item%}">
        {%/foreach%}

        <style>
            {%foreach $tpa_style as $item%}
                {%$item%}
            {%/foreach%}
        </style>
    </head>



    <body>
        {%$smarty.capture.body%}

        {%if $IS_DEV%}
            {%$tpa_js   = tpl_get_src_files($tpa_js, 'js_src/gulp.json')%}
        {%/if%}
        {%foreach $tpa_js as $item%}
            <script src="{%$item%}"></script>
        {%/foreach%}

        <script>
            {%foreach $tpa_script as $item%}
                {%$item%}
            {%/foreach%}
        </script>
    </body>
</html>
