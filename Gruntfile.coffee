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
    stylus:
      # compile:
        # files: "css/style.css": "css/*.styl"
        # files: [{
        #   expand: true
        #   cwd: "styl"
        #   src: "{,*/}*.styl"
        #   dest: "css"
        #   ext: ".css"
        # }]
      dev:
        files: "css/style.css": "css/*.styl"
        options:
          urlfunc: "embedurl"
          compress: false
          linenos: true
          firebug: true
      dist:
        files: "css/style.css": "css/*.styl"
        options:
          urlfunc: "embedurl"

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
      livereload:
        options:
          port: 1337
    open:
      server:
        path: "http://127.0.0.1:<%= connect.livereload.options.port %>"
        app: "Chrome"
    watch:
      jade:
        files: "*.jade"
        tasks: "jade:dev"
      coffee:
        files: "js/*.coffee"
        tasks: "coffee"
      stylus:
        files: "css/style.styl"
        tasks: "stylus:dev"
      compass:
        files: "css/style.sass"
        tasks: "compass:dev"
      options:
        livereload: true

  for taskName of grunt.file.readJSON("package.json").devDependencies when taskName.substring(0, 6) is "grunt-" then grunt.loadNpmTasks taskName

  grunt.registerTask "default", ["connect", "open", "watch"]
  # grunt.registerTask "dist", ["jade:dist", "coffee", "compass:dist", "uglify", "csso"]
  grunt.registerTask "dist", ["jade:dist", "coffee", "stylus:dist", "uglify", "csso"]
  return
