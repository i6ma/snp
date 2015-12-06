{%extends   'html.tpl'%}



{%block 'body'%}
    {%$tpv_title    = $title|cat: ' - page'%}
    {%$tpa_css[]    = 'css/page.css'%}
    {%$tpa_js[]     = 'js/page.js'%}

    <h1>{%$h1text%}</h1>
    <h3 id="h3"></h3>

    {%capture append = tpa_script%}
    <script >
        show_time('h3', time_adjustment); // local time ?
        // show time
    </script>
    {%/capture%}



    {%include   'page_inc.tpl'%}

    {%capture append = tpa_style%}
        <style >
            /* className is better than id*/
            #textarea {
                width: 100%;
                margin-top: 20px;
                color: #00f;
            }
        </style>
    {%/capture%}
{%/block%}
