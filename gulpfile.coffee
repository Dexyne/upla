
gulp    = require('gulp')
sass    = require('gulp-sass')
compass = require('gulp-compass')

gulp.task 'default', ['sass', 'watch'], ->
  # place code for your default task here

gulp.task 'sass', ->
  # compile sass/scss files
  gulp.src(['./assets/sass/**/*.scss', './assets/sass/**/*.sass'])
    .pipe(sass({ errLogToConsole: true }))
    .pipe(gulp.dest('./public/stylesheets'))

gulp.task 'watch', ->
  gulp.watch('./assets/sass/**/*.sass', ['sass'])
  gulp.watch('./assets/sass/**/*.scss', ['sass'])
