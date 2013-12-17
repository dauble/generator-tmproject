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
      dev: [
        'watch'
        'compass:dev'
      ]
      dist: [
        'imagemin'
        'svgmin'
      ]

    compass:
      options:
        sassDir: '<%%= yeoman.app %>/stylesheets'
        cssDir: '<%%= yeoman.app %>/_tmp/stylesheets'
        require: 'breakpoint'
      dev:
        options:
          watch: true
      dist:
        options:
          force: true

    coffee:
      dist:
        expand: true
        cwd: '<%%= yeoman.app %>/javascripts'
        src: '{,*/}*.coffee'
        dest: '<%%= yeoman.app %>/_tmp/javascripts'
        ext: '.js'

    watch:
      scss:
        options:
          spawn: false
        files: ['<%%= yeoman.app %>/stylesheets/{,*/}*.scss']
        tasks: ['notify:scss']

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
          '<%%= yeoman.app %>/_tmp/stylesheets/{,*/}*.css'
          '<%%= yeoman.app %>/_tmp/javascripts/{,*/}*.js'
          '<%%= yeoman.app %>/images/{,*/}*.{gif,jpeg,jpg,png,svg,webp}'
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
          '!**/stylesheets/**'
          '!**/javascripts/**'
          '!**/bower_components/**'
          '!**/_tmp/**'
        ]

      js:
        expand: true
        cwd: '<%%= yeoman.app %>/javascripts/'
        src: ['**/*.js']
        dest: '<%%= yeoman.app %>/_tmp/javascripts/'

      requirejs:
        expand: true
        cwd: '<%%= yeoman.app %>/bower_components'
        src: ['requirejs/require.js']
        dest: '<%%= yeoman.dist %>/bower_components'

    usemin:
      html: ['<%%= yeoman.dist %>/<%%= yeoman.wrapper %>']
      css: ['<%%= yeoman.dist %>/stylesheets/{,*/}*.css']
      options:
        assetsDirs: '<%%= yeoman.dist %>'

    requirejs:
      compile:
        options:
          baseUrl: "<%%= yeoman.app %>/_tmp/javascripts"
          mainConfigFile: "<%%= yeoman.app %>/_tmp/javascripts/config.js"
          dir: '<%%= yeoman.dist %>/javascripts'
          modules: [{ name: 'main' }]
          removeCombined: true

    rev:
      dist:
        files:
          src: [
            '<%%= yeoman.dist %>/stylesheets/{,*/}*.css'
            '<%%= yeoman.dist %>/javascripts/{,*/}*.js'
            '<%%= yeoman.dist %>/images/{,*/}*.{gif,jpeg,jpg,png,svg,webp}'
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
        cwd: '<%%= yeoman.dist %>/images'
        src: '{,*/}*.{gif,jpeg,jpg,png}'
        dest: '<%%= yeoman.dist %>/images'

    svgmin:
      dist:
        expand: true
        cwd: '<%%= yeoman.dist %>/images'
        src: '{,*/}*.svg'
        dest: '<%%= yeoman.dist %>/images'

    uglify:
      requirejs:
        files:
          '<%%= yeoman.dist %>/bower_components/requirejs/require.js': ['<%%= yeoman.dist %>/bower_components/requirejs/require.js']

    handlebars:
      compile:
        options:
          namespace: 'Templates'
          amd: true
        files:
          '<%%= yeoman.app %>/_tmp/javascripts/templates/templates.js': ['<%%= yeoman.app %>/javascripts/templates/{,*/}*.hbs']

    modernizr:
      devFile: '<%%= yeoman.app %>/bower_components/modernizr/modernizr.js'
      outputFile: '<%%= yeoman.dist %>/bower_components/modernizr/modernizr.js'
      files: [
        '<%%= yeoman.dist %>/stylesheets/{,*/}*.css'
        '<%%= yeoman.dist %>/javascripts/{,*/}*.js'
      ]
      uglify: true

    replace:
      dist:
        options:
          patterns: [
            match: '/\/_tmp\/javascripts\//g'
            replacement: '/javascripts/'
            expression: true
          ]
        files: [
          expand: true
          src: '<%%= yeoman.dist %>/<%%= yeoman.wrapper %>'
          dest: '.'
        ]

    casperjs:
      files: 'test/{,*/}*.{coffee,js}'

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
    "compass:dist"
    "coffee"
    "handlebars"
    "concurrent:dev"
  ]

  grunt.registerTask "build", [
    "clean:dist"
    "compass:dist"
    "coffee:dist"
    "handlebars"
    "useminPrepare"
    "concat"
    "cssmin"
    "copy:dist"
    "requirejs"
    "copy:requirejs"
    "uglify"
    "replace:dist"
    "concurrent:dist"
    "modernizr"
    "rev"
    "usemin"
    "notify:dist"
  ]

  grunt.registerTask "test", [
    "casperjs"
  ]