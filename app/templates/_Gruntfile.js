module.exports = function(grunt) {
  require('time-grunt')(grunt);
  grunt.initConfig({
    // configurable paths
    yeoman: {
        app: 'app',
        dist: 'dist',
        <% if (projectTypeEE) { %>
          wrapper: 'templates/default_site/{,*/}*.html'
        <% } else if (projectTypeCraft) { %>
          wrapper: 'craft/templates/{,*/}*.html'
        <% } else { %>
          wrapper: '{,*/}*.html'
        <% } %>
    },
    compass: {
      options: {
        sassDir: '<%%= yeoman.app %>/stylesheets',
        cssDir: '<%%= yeoman.app %>/stylesheets/_compiled',
        relativeAssets: false,
        assetCacheBuster: false,
        require: 'breakpoint'
      },
      dist: {}
    },
    coffee: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%%= yeoman.app %>/javascripts',
          src: '{,*/}*.coffee',
          dest: '<%%= yeoman.app %>/javascripts/_compiled',
          ext: '.js'
        }]
      }
    },
    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%%= yeoman.app %>/images',
          src: '{,*/}*.{png,jpg,jpeg}',
          dest: '<%%= yeoman.dist %>/images'
        }]
      }
    },
    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%%= yeoman.app %>/images',
          src: '{,*/}*.svg',
          dest: '<%%= yeoman.dist %>/images'
        }]
      }
    },
    watch: {
      scss: {
        files: ['<%%= yeoman.app %>/stylesheets/{,*/}*.{scss,sass}'],
        tasks: ['compass:dist']
      },
      css: {
        files: [
          '<%%= yeoman.app %>/stylesheets/{,*/}*.css',
          '!<%%= yeoman.app %>/stylesheets/_compiled/*.css'
        ],
        tasks: ['copy:css']
      },
      coffee: {
        files: ['<%%= yeoman.app %>/javascripts/{,*/}*.coffee'],
        tasks: ['coffee:dist']
      },
      js: {
        files: ['<%%= yeoman.app %>/javascripts/{,*/}*.js'],
        tasks: ['copy:js']
      },
      livereload: {
        options: { livereload: true },
        files: ['<%%= yeoman.app %>/stylesheets/_compiled/*.css']
      }
    },
    copy: {
      dist: {
        expand: true,
        cwd: '<%%= yeoman.app %>',
        src: [
            '**',
            '!**/stylesheets/**',
            '!**/javascripts/**',
            '!**/bower_components/**',
            'images/**/*.gif'
        ],
        dest: '<%%= yeoman.dist %>'
      },
      css: {
        expand: true,
        cwd: '<%%= yeoman.app %>/stylesheets/',
        src: [
            '**/*.css'
        ],
        dest: '<%%= yeoman.app %>/stylesheets/_compiled/'
      },
      js: {
        expand: true,
        cwd: '<%%= yeoman.app %>/javascripts/',
        src: [
            '**/*.js'
        ],
        dest: '<%%= yeoman.app %>/javascripts/_compiled/'
      }
    },
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%%= yeoman.dist %>/*',
            '!<%%= yeoman.dist %>/.git*'
          ]
        }]
      },
      dev: {
        files: [{
          dot: true,
          src: [
            '<%%= yeoman.app %>/javascripts/_compiled',
            '<%%= yeoman.app %>/stylesheets/_compiled'
          ]
        }]
      }
    },
    rev: {
      dist: {
        files: {
          src: [
            '<%%= yeoman.dist %>/stylesheets/{,*/}*.css',
            '<%%= yeoman.dist %>/javascripts/{,*/}*.js'
          ]
        }
      }
    },
    useminPrepare: {
      html: '<%%= yeoman.app %>/<%%= yeoman.wrapper %>',
      options: {
        dest: '<%%= yeoman.dist %>',
        root: '<%%= yeoman.app %>'
      }
    },
    concat: {},
    uglify: {},
    usemin: {
      html: ['<%%= yeoman.dist %>/<%%= yeoman.wrapper %>'],
      css: ['<%%= yeoman.dist %>/stylesheets/{,*/}*.css'],
      options: {
        assetsDirs: '<%%= yeoman.dist %>'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-rev');
  grunt.loadNpmTasks('grunt-usemin');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-svgmin');

  grunt.registerTask('build', [
    'clean',
    'copy:css',
    'copy:js',
    'useminPrepare',
    'compass',
    'coffee',
    'concat',
    'cssmin',
    'uglify',
    'copy:dist',
    'imagemin',
    'svgmin',
    'rev',
    'usemin'
  ]);

  grunt.registerTask('default', [
    'clean:dev',
    'copy:css',
    'copy:js',
    'compass',
    'coffee',
    'watch'
  ]);
}