'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');

var TmprojectGenerator = module.exports = function TmprojectGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({
      skipInstall: options['skip-install'],
      callback: function () {
        // Run bundle install to ensure we have all gem dependencies
        this.spawnCommand('bundle', ['install'])
          .on('exit', function() {
            // Run grunt build for the first time
            this.spawnCommand('grunt', ['build'])
          }.bind(this));
      }.bind(this) // bind the callback to the parent scope
    });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(TmprojectGenerator, yeoman.generators.Base);

TmprojectGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);

  var prompts = [{
    name: 'projectName',
    message: 'What is the project name?'
  }, {
    type: 'list',
    name: 'projectType',
    message: 'What CMS will this project use?',
    choices: [{
      name: 'ExpressionEngine',
      value: 'projectTypeEE',
    }, {
      name: 'Craft',
      value: 'projectTypeCraft'
    }, {
      name: 'None',
      value: 'projectTypeBasic'
    }]
  }];

  this.prompt(prompts, function (props) {
    this.projectName = props.projectName;
    var projectType = props.projectType;

    function hasFeature(feat) { return projectType.indexOf(feat) !== -1; }

    // manually deal with the response, get back and store the results.
    // we change a bit this way of doing to automatically do this in the self.prompt() method.
    this.projectTypeEE = hasFeature('projectTypeEE');
    this.projectTypeCraft = hasFeature('projectTypeCraft');
    this.projectTypeBasic = hasFeature('projectTypeBasic');

    cb();
  }.bind(this));
};

TmprojectGenerator.prototype.bowerJs = function bowerJs() {
  this.copy('_bower.json', 'bower.json');
  this.copy('_bowerrc', '.bowerrc');
};

TmprojectGenerator.prototype.app = function app() {
  // Project essentials
  this.copy('_htaccess', 'app/.htaccess');
  this.copy('_package.json', 'package.json');
  this.copy('_Gruntfile.coffee', 'Gruntfile.coffee');
  this.copy('_Gemfile', 'Gemfile');

  if (this.projectTypeBasic) {
    this.copy('_index.html', 'app/index.html');
  } else if (this.projectTypeCraft) {
    this.mkdir('app/craft/templates');
    this.copy('_index.html', 'app/craft/templates/index.html');
  } else if (this.projectTypeEE) {
    this.mkdir('app/templates/default_site/site.group');
    this.copy('_index.html', 'app/templates/default_site/site.group/index.html');
  }

  // Assets
  this.directory('stylesheets', 'app/stylesheets');
  this.directory('javascripts', 'app/javascripts');
  this.mkdir('app/images');

  // Tests
  this.directory('test')
};

TmprojectGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('gitignore', '.gitignore');
};