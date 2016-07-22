<%capture   'vars'%>
    <%* 模板变量申明等 *%>
    <%include   'vars.tpl'  scope = 'parent'%>
    <%block 'vars'%><%/block%>
<%/capture%>
<!doctype html>
<html lang="zh-CN">
    <%capture   'body'%>
        <%* 页面主体部分的代码，"先执行 后输出"，可以在这里捕获感兴趣的内容，并输出到 head *%>
        <%block 'body'%><%/block%>
    <%/capture%>


    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <title><%$tpv_title%></title>

        <%block 'head'%>
            <%* 这部分代码是 "后执行 先输出"，可以将主体代码中捕获到的特殊内容提前输出 *%>
            <%include   'head.tpl'  scope = 'parent'%>
        <%/block%>
    </head>


    <body>
        <%$smarty.capture.body%>

        <%block 'foot'%>
            <%include   'foot.tpl'  scope = 'parent'%>
        <%/block%>
    </body>
</html>
