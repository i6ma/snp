
<script tpa="">
    var time_adjustment = new Date - <%$smarty.now * 1000%>;    // 客户端时间修正值
    <%* 外链样式脚本文件，通过 document.write 加载 *%>
    <%if $debug%>
        <%include   '../js_src/writer.js'%>
    <%else%>
        <%include   '../js/writer.js'%>
    <%/if%>
</script>


<script tpa="">
writer(
    <%json_encode($tpa_css)%>,
    {
        bas: '<%$tpu_base%>',
        stmp: '<%$stamp_css%>',
        tpl: '<link type="text/css" rel="stylesheet" href="{$src}">',
        eps: <%$tpv_csseps%>
    }
);
<%$tpa_css  = []%>
</script>


<style>
    <%foreach $tpa_style as $item%>
        <%$item%>
    <%/foreach%>
    <%$tpa_style = []%>
</style>

