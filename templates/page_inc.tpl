
{%capture append = tpa_style%}
    <style >
        .button {
            font-size: 20px;                                 /*font-weight: 600;*/
            padding: 0 20px;
        }
    </style>
{%/capture%}

<input id="button" class="button" type="button" value="hello">
<textarea id="textarea">a quick brown fox jumps over the lazy dog</textarea>

{%capture append = tpa_script%}
    <script >
        get_ele('button').onclick = function () {           // y not addEventListener
            this.value = {
                'hello':    'world',
                'world':    'hello'
            }[this.value];
            show_code('textarea');
        }; // hello world
    </script>
{%/capture%}
