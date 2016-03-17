title: gulp学习
date: 2016-01-30 20:44:33
tags:
- gulp
- js

----

# gulp学习

## 简介


## 一个gulp的模板

	var gulp = require('gulp'),                     // 运行task
	    connect = require('gulp-connect'),          // 运行live reload服务器
	    browserify = require('gulp-browserify'),    // 将组件拼接在一起，让浏览器代码也可以通过require方式构建
	    concat = require('gulp-concat'),            // 将所有文件拼在一起
	    port = process.env.port || 5000;
	
	// 任务browserify
	gulp.task('browserify', function() {
	    gulp.src('./app/js/main.js')
	    .pipe(browserify({
	        transform: 'reactify'
	    }))
	    .pipe(gulp.dest('./dist/js'))
	});
	
	// 任务connect： live reload
	gulp.task('connect', function() {
	    connect.server({
	        // root: './',
	        port: port,
	        livereload: true
	    })
	});
	
	// reload js
	gulp.task('js', function() {
	    gulp.src('./dist/**/*.js')
	    .pipe(connect.reload())
	});
	
	gulp.task('html', function() {
	    gulp.src('./app/**/*.html')
	    .pipe(connect.reload())
	});
	
	gulp.task('watch', function() {
	    gulp.watch('./dist/**/*.js', ['js']);
	    gulp.watch('./app/**/*.html', ['html']);
	    gulp.watch('./app/js/**/*.js', ['browserify']);
	});
	
	gulp.task('default', ['browserify']);
	gulp.task('serve', ['browserify', 'connect', 'watch']);
	
	
