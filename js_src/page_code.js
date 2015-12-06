;

function show_code(id) {
    var ele     = get_ele(id);
    ele.value   = get_htm();
    ele.style.height = ele.scrollHeight + 'px';
}
