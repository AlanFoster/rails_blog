'use strict';

var gulp = require('gulp');
var del = require('del');
var plugins = require('gulp-load-plugins')();

var settings = require('./config/js');

gulp.task('assets:javascript', function () {
  return gulp.src(settings.build.js)
             .pipe(plugins.plumber())
             .pipe(plugins.webpack(settings.webpack))
             .pipe(gulp.dest(settings.build.target + '/javascripts'));
});

gulp.task('assets:stylesheets', function() {
  return gulp.src(settings.build.stylesheets.index)
             .pipe(plugins.plumber())
             .pipe(plugins.sourcemaps.init())
             .pipe(plugins.sass({ indentedSyntax: false }).on('error', plugins.sass.logError))
             .pipe(plugins.autoprefixer())
             .pipe(plugins.sourcemaps.write())
             .pipe(plugins.rename('application.css'))
             .pipe(gulp.dest(settings.build.target + '/stylesheets'));
});

gulp.task('assets', ['assets:javascript', 'assets:stylesheets']);
gulp.task('build', ['assets']);

gulp.task('clean', function (cb) {
  return del(settings.build.target + '/**/*', cb);
});

gulp.task('watch', ['clean', 'build'], function() {
  gulp.watch([
    settings.build.js,
    settings.build.stylesheets.watch
  ], ['build'])
});

gulp.task('default', ['clean', 'build']);
