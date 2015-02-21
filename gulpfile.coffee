gulp   = require 'gulp'
coffee = require 'gulp-coffee'
browserify = require 'gulp-browserify'
rename = require 'gulp-rename'
source = require 'vinyl-source-stream'
plumber    = require 'gulp-plumber'

gulp.task 'build', ->
  gulp.src './src/main.coffee'
    .pipe plumber()
    .pipe coffee()
    .pipe gulp.dest './lib/'
  gulp.src './src/sidebar.coffee', {read: false}
    .pipe browserify
      extensions: ['.coffee']
      transform: ['coffee-reactify']
    .pipe plumber()
    .pipe rename 'sidebar.js'
    .pipe gulp.dest "./lib/"


gulp.task 'watch', ->
  gulp.watch('./src/**/*.coffee', ['build'])
