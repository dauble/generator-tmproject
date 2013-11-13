module.exports = (grunt) ->

  require("time-grunt") grunt

# my change

  grunt.initConfig
    yeoman:
      app: 'app'
      dist: 'dist'<% if (projectTypeEE) { %>
      wrapper: 'templates/default_site/{,*/}*.html'<% } else if (projectTypeCraft) { %>
      wrapper: 'craft/templates/{,*/}*.html'<% } else { %>
      wrapper: '{,*/}*.html'<% } %>

    compass:
      options:
        sassDir: '<%%= yeoman.app %>/stylesheets'
        cssDir: '<%%= yeoman.app %>/_compiled/stylesheets'
        relativeAssets: false
        assetCacheBuster: false
        require: 'breakpoint'
      dist: {}

    coffee:
      dist:
        expand: true
        cwd: '<%%= yeoman.app %>/javascripts'
        src: '{,*/}*.coffee'
        dest: '<%%= yeoman.app %>/_compiled/javascripts'
        ext: '.js'

    imagemin:
      dist:
        expand: true
        cwd: '<%%= yeoman.app %>/images'
        src: '{,*/}*.{png,jpg,jpeg}'
        dest: '<%%= yeoman.dist %>/images'

    svgmin:
      dist:
        expand: true
        cwd: '<%%= yeoman.app %>/images'
        src: '{,*/}*.svg'
        dest: '<%%= yeoman.dist %>/images'

    watch:
      scss:
        files: ['<%%= yeoman.app %>/stylesheets/{,*/}*.{scss,sass}']
        tasks: ['compass:dist']

      css:
        files: ['<%%= yeoman.app %>/stylesheets/{,*/}*.css']
        tasks: ['copy:css']

      coffee:
        files: ['<%%= yeoman.app %>/javascripts/{,*/}*.coffee']
        tasks: ['coffee:dist','notify:coffee']

      js:
        files: ['<%%= yeoman.app %>/javascripts/{,*/}*.js']
        tasks: ['copy:js']

      handlebars:
        files: [
          '<%%= yeoman.app %>/javascripts/templates/{,*/}*.hbs'
        ]
        tasks: ['handlebars']

      livereload:
        options: livereload: true
        files: ['<%%= yeoman.app %>/_compiled/stylesheets/*.css']

    copy:
      dist:
        expand: true
        cwd: '<%%= yeoman.app %>'
        src: [
            '**',
            '!**/_compiled/**',
            '!**/stylesheets/**',
            '!**/javascripts/**',
            '!**/bower_components/**',
            'images/**/*.gif'
        ]
        dest: '<%%= yeoman.dist %>'

      requirejs:
        expand: true
        cwd: '<%%= yeoman.app %>/bower_components'
        src: [
          'requirejs/require.js'
          'modernizr/modernizr.js'
        ]
        dest: '<%%= yeoman.dist %>/bower_components'

      css:
        expand: true
        cwd: '<%%= yeoman.app %>/stylesheets/'
        src: ['**/*.css']
        dest: '<%%= yeoman.app %>/_compiled/stylesheets/'

      js:
        expand: true
        cwd: '<%%= yeoman.app %>/javascripts/'
        src: ['**/*.js']
        dest: '<%%= yeoman.app %>/_compiled/javascripts/'

    clean:
      dist:
        dot: true
        src: [
          '.tmp',
          '<%%= yeoman.dist %>/*',
          '!<%%= yeoman.dist %>/.git*'
        ]

      dev:
        dot: true
        src: [
          '<%%= yeoman.app %>/_compiled/javascripts',
          '<%%= yeoman.app %>/_compiled/stylesheets'
        ]

      tmp:
        dot: true
        src: [
          '.tmp'
        ]

    rev:
      dist:
        files:
          src: [
            '<%%= yeoman.dist %>/stylesheets/{,*/}*.css',
            '<%%= yeoman.dist %>/javascripts/{,*/}*.js'
          ]

    useminPrepare:
      html: '<%%= yeoman.app %>/<%%= yeoman.wrapper %>'
      options:
        dest: '<%%= yeoman.dist %>'
        root: '<%%= yeoman.app %>'

    concat: {}

    uglify: {}

    usemin:
      html: ['<%%= yeoman.dist %>/<%%= yeoman.wrapper %>']
      css: ['<%%= yeoman.dist %>/stylesheets/{,*/}*.css']
      options:
        assetsDirs: '<%%= yeoman.dist %>'

    notify:
      coffee:
        options:
          title: 'Task: Coffee complete'
          message: 'Grunt has finished compiling your coffee scripts'
      dist:
        options:
          title: "Build complete"
          message: "Grunt has finished compiling your build in /<%%= yeoman.dist %>/"

    handlebars:
      compile:
        options:
          namespace: 'Templates'
          amd: true
        files:
          '<%%= yeoman.app %>/_compiled/javascripts/templates/templates.js': ['<%%= yeoman.app %>/javascripts/templates/{,*/}*.hbs']
    requirejs:
      compile:
        options:
          baseUrl: "<%%= yeoman.app %>/_compiled/javascripts"
          mainConfigFile: "<%%= yeoman.app %>/_compiled/javascripts/config.js"
          dir: '<%%= yeoman.dist %>/javascripts'
          modules: [{ name: 'main' }]
          removeCombined: true

    replace:
      dist:
        options:
          patterns: [
            match: '/\/_compiled\/javascripts\//g'
            replacement: '/javascripts/'
            expression: true
          ]
        files: [
          expand: true
          src: '<%%= yeoman.dist %>/<%%= yeoman.wrapper %>'
          dest: '.'
        ]

  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-rev"
  grunt.loadNpmTasks "grunt-usemin"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-svgmin"
  grunt.loadNpmTasks "grunt-notify"
  grunt.loadNpmTasks "grunt-replace"
  grunt.loadNpmTasks "grunt-contrib-handlebars"

  grunt.registerTask "build", [
    "clean:dist",
    "clean:dev",
    "copy:css",
    "copy:js",
    "useminPrepare",
    "compass",
    "coffee",
    "handlebars"
    "concat",
    "cssmin",
    "copy:dist",
    "imagemin",
    "svgmin",
    "requirejs"
    "copy:requirejs"
    "replace:dist"
    "rev",
    "usemin",
    "clean:tmp"
    "notify:dist"
  ]

  grunt.registerTask "default", [
    "clean:dev",
    "copy:css",
    "copy:js",
    "compass",
    "coffee",
    "handlebars"
    "watch"
  ]