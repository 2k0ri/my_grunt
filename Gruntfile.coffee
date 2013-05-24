path = require("path")
lrSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet
folderMount = (connect, point) -> connect.static path.resolve(point)

module.exports = (grunt) ->

  grunt.initConfig
    uglify:
      dist: 
        files: [{
          expand: true
          cwd: "js"
          src: "{,*/}*.js"
          dest: "js"
          ext: ".js"
        }]
    csso:
      dist:
        files: [{
          expand: true
          cwd: "css"
          src: "{,*/}*.css"
          dest: "css"
          ext: ".css"
        }]
    jade:
      dev:
        options:
          pretty: true
        files: [{
          expand: true
          src: "{,*/}*.jade"
          ext: ".html"
        }]
      dist:
        files: [{
          expand: true
          src: "{,*/}*.jade"
          ext: ".html"
        }]
    coffee:
      dist:
        files: [{
          expand: true
          cwd: "js"
          src: "{,*/}*.coffee"
          dest: "js"
          ext: ".js"
        }]
        options:
          bare: true
    # stylus:
    #   compile:
    #     files: "css/style.css": "css/style.styl"
    #     options:
    #       urlfunc: "embedurl"
    #       # compress: true
    compass:
      options:
        cssDir: "css"
        sassDir: "css"
        imagesDir: "img"
        javascriptDir: "js"
        relativeAssets: true
        # force: true
      dev:
        options:
          environment: "development"
          debugInfo: true
      dist:
        options:
          environment: "production"
          force: true
    connect:
      options:
        port: 1337
      livereload:
        options:
          middleware: (connect, options) -> [lrSnippet, folderMount(connect, ".")]
    open:
      server:
        path: 'http://localhost:<%= connect.options.port %>'
    regarde:
      jade:
        files: "*.jade"
        tasks: "jade:dev"
      coffee:
        files: "js/*.coffee"
        tasks: "coffee"
      # stylus:
      #   files: "css/*.styl"
      #   tasks: "stylus"
      compass:
        files: "css/*.sass"
        tasks: "compass:dev"
      livereload:
        files: ["*.html", "js/*.js", "css/*.css"]
        tasks: "livereload"

  for taskName of grunt.file.readJSON("package.json").devDependencies when taskName.substring(0, 6) is "grunt-" then grunt.loadNpmTasks taskName

  grunt.registerTask "default", ["livereload-start", "connect", "open", "regarde"]
  grunt.registerTask "dist", ["jade:dist", "coffee", "compass:dist", "uglify", "csso"]
  return
