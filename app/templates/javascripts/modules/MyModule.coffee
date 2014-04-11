$ = require 'jquery'
Template = require '../templates/myModule.hbs'

class MyModule

    constructor: ->

        $('body').append Template()

        console.log 'constructor: MyModule with templates'

MyModule

module.exports = MyModule