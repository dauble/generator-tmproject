module.exports = (grunt) ->

  require('load-grunt-tasks') grunt
  require("time-grunt") grunt

  grunt.initConfig
    yeoman:
      app: 'app'
      dist: 'dist'<% if (projectTypeEE) { %>
      wrapper: 'templates/default_site/{,*/}*.html'<% } else if (projectTypeCraft) { %>
      wrapper: 'craft/templates/{,*/}*.html'<% } else { %>
      wrapper: '{,*/}*.html'<% } %>

    concurrent:
      dist: [
        'imagemin'
        'svgmin'
      ]

    autoprefixer:
      dist:
        src: '<%%= yeoman.app %>/_tmp/stylesheets/styles.css'

    sass:
      dist:
        options:
          outputStyle: 'compressed'
        files:
          '<%%= yeoman.app %>/_tmp/stylesheets/styles.css': '<%%= yeoman.app %>/assets/stylesheets/styles.scss'
      dev:
        options:
          outputStyle: 'expanded'
          sourceComments: 'normal'
        files:
          '<%%= yeoman.app %>/_tmp/stylesheets/styles.css': '<%%= yeoman.app %>/assets/stylesheets/styles.scss'

    browserify:
      dist:
        files:
          '<%%= yeoman.app %>/_tmp/javascripts/bundle.js': ['<%%= yeoman.app %>/assets/javascripts/{,*/}*.js', '<%%= yeoman.app %>/assets/javascripts/{,*/}*.coffee']
        options:
          transform: ['browserify-handlebars', 'coffeeify']

    watch:
      scss:
        options:
          spawn: false
        files: ['<%%= yeoman.app %>/assets/stylesheets/{,*/}*.scss']
        tasks: ['sass:dev', 'autoprefixer', 'notify:scss']

      coffee:
        options:
            spawn: false
          files: ['<%%= yeoman.app %>/assets/javascripts/{,*/}*.coffee']
          tasks: [
            'browserify:dist'
            'notify:coffee'
          ]

      js:
        files: ['<%%= yeoman.app %>/assets/javascripts/{,*/}*.js']
        tasks: ['copy:js']

      handlebars:
        options:
          spawn: false
        files: ['<%%= yeoman.app %>/assets/javascripts/templates/{,*/}*.hbs']
        tasks: [
          'browserify:dist'
          'notify:coffee'
        ]

      livereload:
        options:
          livereload: true
          spawn: false
        files: [
          '<%%= yeoman.app %>/_tmp/stylesheets/{,*/}*.css'
          '<%%= yeoman.app %>/_tmp/javascripts/{,*/}*.js'
          '<%%= yeoman.app %>/assets/images/{,*/}*.{gif,jpeg,jpg,png,svg,webp}'
        ]

    useminPrepare:
      html: '<%%= yeoman.app %>/<%%= yeoman.wrapper %>'
      options:
        dest: '<%%= yeoman.dist %>'
        root: '<%%= yeoman.app %>'

    copy:
      dist:
        expand: true
        dot: true
        cwd: '<%%= yeoman.app %>'
        dest: '<%%= yeoman.dist %>'
        src: [
          '**'
          '!**/assets/stylesheets/**'
          '!**/assets/javascripts/**'
          '!**/bower_components/**'
          '!**/_tmp/**'
        ]

      js:
        expand: true
        cwd: '<%%= yeoman.app %>/assets/javascripts/'
        src: ['**/*.js']
        dest: '<%%= yeoman.app %>/_tmp/javascripts/'

    usemin:
      html: ['<%%= yeoman.dist %>/<%%= yeoman.wrapper %>']
      css: ['<%%= yeoman.dist %>/assets/stylesheets/{,*/}*.css']
      options:
        assetsDirs: '<%%= yeoman.dist %>'

    rev:
      dist:
        files:
          src: [
            '<%%= yeoman.dist %>/assets/stylesheets/{,*/}*.css'
            '<%%= yeoman.dist %>/assets/javascripts/{,*/}*.js'
            '<%%= yeoman.dist %>/assets/images/{,*/}*.{gif,jpeg,jpg,png,svg,webp}'
          ]

    clean:
      dist:
        dot: true
        src: [
          '_tmp'
          '<%%= yeoman.dist %>/*'
        ]

      dev:
        dot: true
        src: [
          '<%%= yeoman.app %>/_tmp'
        ]

    imagemin:
      dist:
        expand: true
        cwd: '<%%= yeoman.dist %>/assets/images'
        src: '{,*/}*.{gif,jpeg,jpg,png}'
        dest: '<%%= yeoman.dist %>/assets/images'

    svgmin:
      dist:
        expand: true
        cwd: '<%%= yeoman.dist %>/assets/images'
        src: '{,*/}*.svg'
        dest: '<%%= yeoman.dist %>/assets/images'

    modernizr:
      devFile: '<%%= yeoman.app %>/bower_components/modernizr/modernizr.js'
      outputFile: '<%%= yeoman.dist %>/bower_components/modernizr/modernizr.js'
      files: [
        '<%%= yeoman.dist %>/assets/stylesheets/{,*/}*.css'
        '<%%= yeoman.dist %>/assets/javascripts/{,*/}*.js'
      ]
      uglify: true

    notify:
      scss:
        options:
          title: 'Sass compiled'
          message: 'Grunt successfully compiled your Sass files'
      coffee:
        options:
          title: 'CoffeeScript compiled'
          message: 'Grunt successfully compiled your CoffeeScript files'
      handlebars:
        options:
          title: 'Handlebars compiled'
          message: 'Grunt successfully compiled your Handlebars files'
      dist:
        options:
          title: "Build complete"
          message: "Grunt successfully compiled your build in /<%%= yeoman.dist %>/"

  grunt.registerTask "default", [
    "clean:dev"
    "copy:js"
    "sass:dev"
    "autoprefixer"
    "browserify"
    "watch"
  ]

  grunt.registerTask "build", [
    "clean:dist"
    "sass:dist"
    "autoprefixer"
    "browserify:dist"
    "useminPrepare"
    "concat"
    "cssmin"
    "copy:dist"
    "uglify"
    "concurrent:dist"
    "modernizr"
    "rev"
    "usemin"
    "notify:dist"
  ]