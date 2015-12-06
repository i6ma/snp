function show_time(id, adjustment) {
    (function () {
        var now = new Date(new Date - (adjustment || 0));
        get_ele(id).innerHTML = now;
        setTimeout(arguments.callee, 200);
    })();
}
function show_code(id) {
    var ele     = get_ele(id);
    ele.value   = get_htm();
    ele.style.height = ele.scrollHeight + 'px';
}
