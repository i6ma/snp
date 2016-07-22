
<script tpa="">
writer(
    <%json_encode($tpa_js)%>,
    {
        bas: '<%$tpu_base%>',
        stmp: '<%$stamp_js%>',
        eps: <%$tpv_jseps%>
    }
);
<%$tpa_js   = []%>
</script>


<script>
    <%foreach $tpa_script as $item%>
        <%$item%>
    <%/foreach%>
    <%$tpa_script = []%>
</script>

