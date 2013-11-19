module.exports = (grunt) ->

  require("time-grunt") grunt

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
      dev:
        options:
          watch: true
      dist:
        options:
          force: true

    concurrent:
      compile: [
        'compass:dev'
        'watch'
      ]

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
        cwd: '<%%= yeoman.dist %>/images'
        src: '**/*.{png,jpg,jpeg}'
        dest: '<%%= yeoman.dist %>/images'

    svgmin:
      dist:
        expand: true
        cwd: '<%%= yeoman.dist %>/images'
        src: '**/*.svg'
        dest: '<%%= yeoman.dist %>/images'

    watch:
      scss:
        options:
          spawn: false
        files: ['<%%= yeoman.app %>/stylesheets/{,*/}*.scss']
        tasks: ['notify:scss']

      css:
        files: ['<%%= yeoman.app %>/stylesheets/{,*/}*.css']
        tasks: ['copy:css']

      coffee:
        options:
          spawn: false
        files: ['<%%= yeoman.app %>/javascripts/{,*/}*.coffee']
        tasks: [
          'coffee:dist'
          'notify:coffee'
        ]

      js:
        files: ['<%%= yeoman.app %>/javascripts/{,*/}*.js']
        tasks: ['copy:js']

      handlebars:
        options:
          spawn: false
        files: ['<%%= yeoman.app %>/javascripts/templates/{,*/}*.hbs']
        tasks: [
          'handlebars'
          'notify:handlebars'
        ]

      livereload:
        options:
          livereload: true
          spawn: false
        files: [
          '<%%= yeoman.app %>/_compiled/stylesheets/{,*/}*.css'
          '<%%= yeoman.app %>/_compiled/javascripts/{,*/}*.js'
          '<%%= yeoman.app %>/images/**/*.{gif,jpeg,jpg,png,svg,webp}'
        ]

    copy:
      dist:
        expand: true
        dot: true
        cwd: '<%%= yeoman.app %>'
        src: [
            '**'
            '!**/_compiled/**'
            '!**/stylesheets/**'
            '!**/javascripts/**'
            '!**/bower_components/**'
        ]
        dest: '<%%= yeoman.dist %>'

      requirejs:
        expand: true
        cwd: '<%%= yeoman.app %>/bower_components'
        src: ['requirejs/require.js']
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
          '.tmp'
          '<%%= yeoman.dist %>/*'
          '!<%%= yeoman.dist %>/.git*'
        ]

      dev:
        dot: true
        src: [
          '<%%= yeoman.app %>/_compiled/javascripts'
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
            '<%%= yeoman.dist %>/stylesheets/{,*/}*.css'
            '<%%= yeoman.dist %>/javascripts/{,*/}*.js'
          ]

    useminPrepare:
      html: '<%%= yeoman.app %>/<%%= yeoman.wrapper %>'
      options:
        dest: '<%%= yeoman.dist %>'
        root: '<%%= yeoman.app %>'

    concat: {}

    uglify:
      requirejs:
        files:
          '<%%= yeoman.dist %>/bower_components/requirejs/require.js': ['<%%= yeoman.dist %>/bower_components/requirejs/require.js']

    usemin:
      html: ['<%%= yeoman.dist %>/<%%= yeoman.wrapper %>']
      css: ['<%%= yeoman.dist %>/stylesheets/{,*/}*.css']
      options:
        assetsDirs: '<%%= yeoman.dist %>'

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
          message: 'Grunt successfully compiled your Handlebar files'
      dist:
        options:
          title: "Build complete"
          message: "Grunt successfully compiled your build in /<%%= yeoman.dist %>/"

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

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.registerTask "build", [
    "clean:dist"
    "clean:dev"
    "copy:css"
    "copy:js"
    "useminPrepare"
    "compass:dist"
    "coffee"
    "handlebars"
    "concat"
    "cssmin"
    "copy:dist"
    "imagemin"
    "svgmin"
    "requirejs"
    "copy:requirejs"
    "uglify"
    "replace:dist"
    "rev"
    "usemin"
    "clean:tmp"
    "notify:dist"
  ]

  grunt.registerTask "default", [
    "clean:dev"
    "copy:css"
    "copy:js"
    "compass:dist"
    "coffee"
    "handlebars"
    "concurrent"
  ]