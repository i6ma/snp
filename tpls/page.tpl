<%extends   'html.tpl'%>



<%block 'vars'  append%>
    <%$tpv_title    = $title|cat: ' - page'%>

    <%$tpa_css[]    = 'css/page.css'%><%* 给出线上模式所需加载的外链文件 *%>
    <%$tpa_js[]     = 'js/page.js'%><%* 线下模式时，会依据配置文件展开成开发代码 *%>
<%/block%>



<%block 'body'%>
    <h1><%$h1text%></h1>
    <h3 id="h3"></h3>

    <script tpa="script">
        show_time('h3', time_adjustment); // show_time 函数在外链脚本 page_time.js 中定义
    </script>

    <%include   'textarea.tpl'%>

<%/block%>
