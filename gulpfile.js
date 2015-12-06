;

var gulp        = require('gulp');
var minifycss   = require('gulp-minify-css');
var uglify      = require('gulp-uglify');
var concat      = require('gulp-concat');



gulp.task('styles', function () {
    var list    = get_task_list(require('./css_src/gulp.json'));
    for (var i  = 0; i < list.length; i++) {
        var item = list[i];
        gulp.src(item.srcs)
            .pipe(concat(item.concat))
            .pipe(minifycss({compatibility: 'ie8'}))
            .pipe(gulp.dest(item.dest));
    }
});



gulp.task('scripts', function () {
    var list    = get_task_list(require('./js_src/gulp.json'));
    for (var i  = 0; i < list.length; i++) {
        var item = list[i];
        gulp.src(item.srcs)
            .pipe(concat(item.concat))
            .pipe(uglify())
            .pipe(gulp.dest(item.dest));
    }
});



gulp.task('default', function() {
    gulp.start('styles');
    gulp.start('scripts');
});





function get_task_list(info_list) {
    var list        = [];
    var dir_dist    = '';
    var dir_src     = '';
    for (var i = 0; i < info_list.length; i++) {
        var item    = info_list[i];
        if (item.dist.slice(-1) === '/') {
            dir_dist = item.dist.slice(0, -1);
            dir_src = item.srcs[0].slice(0, -1);
            continue;
        }
        if (!item.skip) {
            list.push(task_info_dir(item, dir_dist, dir_src));
        }
    }
    return list;
}



function task_info_dir(item, dir_dist, dir_src) {
    var dest    = item.dist.split('/');
    var concat  = dest.pop();
    if (dir_dist) {
        dest.unshift(dir_dist);
    }
    item.dest   = item.dest || dest.join('/');
    item.concat = item.concat || concat;
    if (dir_src) {
        var srcs    = item.srcs;
        for (var i  = srcs.length; i--;) {
            srcs[i] = dir_src + '/' + srcs[i];
        }
    }
    return item;
}
