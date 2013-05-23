path = require('path')
lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet
folderMount = (connect, point) -> connect.static path.resolve(point)

module.exports = (grunt) ->

  grunt.initConfig
    uglify:
      dist:
        src: ["js/script.js"]
        dest: "js/script.js"
    csso:
      "css/style.css": "css/style.css"
    jade:
      compile:
        options:
          pretty: true
        files:
          "index.html": "index.jade"
      dist:
        compile:
          files:
            "index.html": "index.jade"
    coffee:
      compile:
        files:
          "js/script.js": "js/script.coffee"
        options:
          bare: true
    # stylus:
    #   compile:
    #     files: "css/style.css": "css/style.styl"
    #     options:
    #       urlfunc: "embedurl"
    #       # compress: true
    compass:
      dev:
        options:
          environment: 'development'
      dist:
        options:
          environment: 'production'
    connect:
      livereload:
        options:
          port: 1337
          middleware: (connect, options) -> [lrSnippet, folderMount(connect, '.')]
    regarde:
      fred:
        files: ["*.html","css/*.css","js/*.js"]
        tasks: ["livereload"]
    watch:
      jade:
        files: "*.jade"
        tasks: "jade"
      coffee:
        files: "js/*.coffee"
        tasks: "coffee"
      # stylus:
      #   files: "css/style.styl"
      #   tasks: "stylus"
      compass:
        files: "css/*.sass"
        tasks: "compass:dev"
      # livereload:
      #   files: ["index.html", "js/script.js", "css/style.css"]
      #   tasks: "livereload"

  for taskName of grunt.file.readJSON('package.json').devDependencies when taskName.substring(0, 6) is 'grunt-' then grunt.loadNpmTasks taskName

  grunt.registerTask "default", ["jade", "coffee", "compass"]
  grunt.registerTask "dist", ["jade:dist", "coffee", "compass", "uglify", "csso"]
  grunt.registerTask "live", ["livereload-start", "connect", "regarde"]
  return
