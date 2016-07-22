
// 外链样式脚本文件，通过 document.write 加载

var writer = (function () {
    var dopts   = {
        bas:    '/',
        stmp:   '',
        tpl:    ['<script src="{$src}"><', 'script>'].join('/'),
        eps:    [],
        rpt:    {}
    };

    function writer(list, opts) {
        if (typeof list === 'string') {
            list = [list];
        }
        opts = scopy(opts, dopts);
        for (var i = 0; i < list.length; i++) {
            var item = list[i];
            if (!(item in opts.rpt)) {
                opts.rpt[item] = 1;
                write(expand(item, opts.eps), opts);
            }
        }
    }

    function write(srcs, opts) {
        for (var i = 0; i < srcs.length; i++) {
            var src = srcs[i];
            if (!(src.charAt(0) === '/' || src.slice(0, 2) === './' || src.indexOf('://') > 0)) {
              // 以 (/) (//) 开头，或者以 (./) 开头，或者包含 (://) 的地址，不添加 bas
              // 注意 (../) 开头的地址，也会加 bas，如果需要当前父路径，请使用 (./../)
                src = opts.bas + src;
            }
            if (src.slice(-1) === '#') {
                src = src.slice(0, -1);
            } else if (opts.stmp) {
                src += src.indexOf('?') > 0 ? '&' : '?';
                src += opts.stmp;
            }
            document.write(opts.tpl.split('{$src}').join(src));
        }
    }

    function scopy(target, source) {
        target = target || {};
        for (var k in source) {
            if (!(k in target)) {
                target[k] = source[k];
            }
        }
        return target;
    }

    function expand(item, expans) {
        var hash = item.slice(-1) === '#' ? '#' : '';
        hash && (item = item.slice(0, -1));
        var list    = [];
        var dir_dst = '';
        var dir_src = '';
        for (var i  = 0; i < expans.length; i++) {
            var dist = expans[i].dist;
            var srcs = expans[i].srcs;
            if (typeof srcs === 'string') {
                srcs = [srcs];
            }
            if (dist.slice(-1) === '/') {
                dir_dst = dist;
                dir_src = srcs[0];
            } else if (dir_dst + dist === item) {
                for (var j = srcs.length; j--;) {
                    list[j] = dir_src + srcs[j] + hash;
                }
                break;
            }
        }
        return list.length ? list : [item + hash];
    }

    return writer;
})();

