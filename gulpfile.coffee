gulp   = require 'gulp'
cjsx = require 'gulp-cjsx'

gulp.task 'build', ->
  gulp.src './src/**/*.coffee'
    .pipe cjsx({bare: true})
    .pipe gulp.dest('./lib/')

gulp.task 'watch', ->
  gulp.watch('./src/**/*.coffee', ['build'])
  
