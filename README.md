generator-tmproject
===================

This is a project generator to quick start a new web project. This Yeoman generator will set up your directories and provide you with two Grunt tasks: `$ grunt` for development and `$ grunt build` to compile your project.

## Requirements
* [Bundler](http://bundler.io/) `$ gem install bundler`
* [node.js](http://nodejs.org/)
* [Grunt](http://gruntjs.com/) `$ npm install -g grunt-cli`
* [Yeoman](http://yeoman.io/) `$ npm install -g yo`

## Installing generator-tmproject
Run `$ npm install -g generator-tmproject`

## Setup a new project
1. Create an empty directory for your project: `$ mkdir ~/Sites/my_new_project && cd $_`
2. Run the generator: `$ yo tmproject`

## Project directories
You will be asked a couple basic questions to start your project up. When you are done you should have a project directory that looks like this:

```
+ app
  + bower_components/
  + images/
  + javascripts/
  + stylesheets/
  .htaccess
  index.html
+ dist
  + javascripts/
  + images/
  + stylesheets/
  .htaccess
  index.html
.bowerrc
.gitignore
bower.json
Gemfile
Gruntfile.coffee
package.json
```

## About your new project
### bower_components/
[Bower](http://bower.io) will manage your project dependencies. If you run jQuery, Fancybox, Flexsider or any other libraries this is where they'll live.

#### Adding libraries to your project
If you need to add Fancybox to your project you can search the Bower library for it by running `$ bower search fancybox`. Once you find the one you are looking for, just run `$ bower install fancybox -S` and the Fancybox library will now be in `app/bower_components`. You can also remove a dependency by running `$ bower uninstall fancybox -S`.

**Note:** You must use `-S` in your bower command to add the dependency to your `bower.json` file.

#### Related files
`.bowerrc`: Configures the path to the `bower_components` directory (don't change this)
`bower.json`: Specifies all of the dependencies used in the project.

### images/
Place any project images in this directory. Running `$ grunt build` will move your images to `dist/images` and compress them.

### javascripts/
You are able to use `.js` and `.coffee` files. If you are running the `$ grunt` process, you may want to restart it when creating new files.

#### Paths
If you want to reference a `.js` or `.coffee` file in your template you *must* use `_compiled` in your path. For example, if your `.js` file is located at `javascripts/form/myfile.js` your HTML should be `<script src="/_compiled/javascripts/form/myfile.js"></script>`.

#### Using CoffeeScript
CoffeeScript files must be referenced with a `.js` extension. For example, if your CoffeeScript file is located at `javascripts/form/myfile.coffee` your HTML should be `<script src="/_compiled/javascripts/form/myfile.js"></script>`.

### stylesheets/
You are able to use `.scss` and `.css` files (though I'd recommend just using `.scss`). If you are running the `$ grunt` process, you may want to restart it when creating new files.

#### Paths
If you want to reference a `.scss` or `.css` file in your template you *must* use `_compiled` in your path. For example, if your `.scss` file is located at `stylesheets/myfile.scss` your HTML should be `<link rel="stylesheet" href="/_compiled/stylesheets/myfile.css">`.

### dist/
This is the compiled version of your web project. You deploy this, and only this, folder to the web server.

### Miscellaneous files
- `.gitignore`: A standard gitignore file to ignore compiled directories and other OS-based files and folders.
- `.htaccess`: A basic htaccess file provided by the [HTML5 Boilerplate](https://github.com/h5bp/html5-boilerplate/blob/master/.htaccess).
- `Gemfile`: A list of Ruby gem dependencies for the project
- `Gruntfile.js`: A list of the tasks that run on `$ grunt` and `$ grunt build`
- `package.json`: A list of dependencies for the Grunt tasks.

## Release History
* 2013-12-17 - v1.4.1 - Add mixins to make transition away from Compass easier
* 2013-12-17 - v1.4.0 - Use Sass instead of Compass because Sass is much faster
* 2013-12-17 - v1.3.5 - Optimize RequireJS scripts
* 2013-12-17 - v1.3.4 - Add conditional gitignore
* 2013-12-17 - v1.3.3 - Fix .tmp directories not being accessible from web
* 2013-12-17 - v1.3.2 - Add CasperJS test library for [BDD](http://en.wikipedia.org/wiki/Behavior-driven_development)
* 2013-12-16 - v1.3.1 - Update time-grunt
* 2013-12-15 - v1.3.0 - Rewrite Grunt tasks for efficiency
* 2013-12-11 - v1.2.7 - Add custom Modernizr generator
* 2013-11-14 - v1.2.6 - Change Compass dist action to recompile from scratch
* 2013-11-14 - v1.2.5 - Setup images to use LiveReload
* 2013-11-14 - v1.2.4 - Setup JavaScript and CoffeeScript to use LiveReload
* 2013-11-14 - v1.2.3 - Use MatchDep to automatically match dependencies
* 2013-11-14 - v1.2.2 - Drastically speed up .scss compiling and LiveReload using Concurrent
* 2013-11-13 - v1.2.1 - Minify RequireJS
* 2013-11-13 - v1.2.0 - Add RequireJS and Handlebars.js functionality (shout out to @drgfunk)
* 2013-11-11 - v1.1.0 - Adds bundle functionality to retreive gem dependencies
* 2013-11-11 - v1.0.7 - Fixes issue where all files in images/ may not be compressed and copied over
* 2013-11-11 - v1.0.6 - Fixes issue where .htaccess wasn't in app/ and didn't copy to dist/
* 2013-10-30 - v1.0.5 - Remove .tmp directory after build is complete
* 2013-10-29 - v1.0.4 - Fixes issue where compiled CSS/JS compiles infinitely
* 2013-10-25 - v1.0.3 - Fixes usemin issues with ExpressionEngine and Craft options
* 2013-10-18 - v1.0.2 - Add notify script to notify when a build is complete
* 2013-10-18 - v1.0.1 - Use a CoffeeScript Gruntfile so it is easier to read