
<style tpa="style">
    .button {
        font-size: 20px;
        /*font-weight: 600;*/
        padding: 0 20px;
    }
    #textarea { /* 一般不要用 id 选择器 */
        width: 100%;
        margin-top: 20px;
        color: #00f;
    }
</style>


<input id="button" class="button" type="button" value="hello">
<textarea id="textarea">a quick brown fox jumps over the lazy dog</textarea>


<script tpa="script">
    get_ele('button').onclick = function () {       // 推荐用 addEventListener 绑定事件监听
        this.value = {
            'hello':    'world',
            'world':    'hello'
        }[this.value];
        show_code('textarea');
    };
</script>

