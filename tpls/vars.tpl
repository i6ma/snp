
<%* 模板变量申明等，这部分代码应该被包在 capture 内，不让这里产生的空白输出给浏览器 *%>

<%$tpu_base     = explode('/', $smarty.server.SCRIPT_NAME)%>
<%$tpu_base[count($tpu_base) - 1] = ''%>
<%$tpu_base     = implode('/', $tpu_base)%>

<%$stamp_css    = '160720'%>
<%$stamp_js     = '160721'%>

<%$tpa_css      = []%>
<%$tpa_js       = []%>

<%$tpa_style    = []%>
<%$tpa_script   = []%>

<%$tpa_css[]    = 'css/style.css'%>
<%$tpa_js[]     = 'js/script.js'%>

<%if $debug%>
    <%* 线下、调试模式，依据配置文件信息，将线上外链地址展开成开发文件地址 *%>
    <%include   '../css_src/gulp.json'  assign = 'tpv_csseps'%>
    <%include   '../js_src/gulp.json'   assign = 'tpv_jseps'%>
<%else%>
    <%$tpv_csseps   = '[]'%>
    <%$tpv_jseps    = '[]'%>
<%/if%>

