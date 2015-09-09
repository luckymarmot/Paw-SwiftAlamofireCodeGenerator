{exec} = require 'child_process'
{ncp} = require 'ncp'
mkdirp = require 'mkdirp'
fs = require 'fs'

file = 'SwiftAlamofireCodeGenerator.coffee'
identifier = 'com.luckymarmot.PawExtensions.SwiftAlamofireCodeGenerator'

extensions_dir = "#{ process.env.HOME }/Library/Containers/com.luckymarmot.Paw/Data/Library/Application Support/com.luckymarmot.Paw/Extensions/"
build_root_dir = "build"
build_dir = "#{ build_root_dir }/#{ identifier }"

# compile CoffeeScript
build_coffee = (callback) ->
    console.log "Building Coffee Scripts..."

    coffee = exec "./node_modules/coffee-script/bin/coffee -c -o #{ build_dir } #{ file }"
    coffee.stderr.on 'data', (data) ->
        process.stderr.write data.toString()
    coffee.stdout.on 'data', (data) ->
        process.stdout.write data.toString()
    coffee.on 'exit', (code) ->
        if code is 0
            console.log " > DONE"
            callback?()
        else
            console.error " > FAILED: Build failed with error: #{ code }"
            process.exit(code=code)

# copy files to build directory
build_copy = () ->
    console.log "Copying files to archive..."

    fs.writeFileSync "#{ build_dir }/README.md", fs.readFileSync("./README.md")
    fs.writeFileSync "#{ build_dir }/LICENSE", fs.readFileSync("./LICENSE")
    fs.writeFileSync "#{ build_dir }/swift.mustache", fs.readFileSync("./swift.mustache")
    fs.writeFileSync "#{ build_dir }/mustache.js", fs.readFileSync("./node_modules/mustache/mustache.js")
    fs.writeFileSync "#{ build_dir }/URI.js", fs.readFileSync("./node_modules/URIjs/src/URI.js")
    fs.writeFileSync "#{ build_dir }/punycode.js", fs.readFileSync("./node_modules/URIjs/src/punycode.js")
    fs.writeFileSync "#{ build_dir }/IPv6.js", fs.readFileSync("./node_modules/URIjs/src/IPv6.js")
    fs.writeFileSync "#{ build_dir }/SecondLevelDomains.js", fs.readFileSync("./node_modules/URIjs/src/SecondLevelDomains.js")
    # legacy
    fs.writeFileSync "#{ build_dir }/URI.min.js", fs.readFileSync("./node_modules/URIjs/src/URI.min.js")

    console.log " > DONE"

# build: build CoffeeScript and copy files to build directory
build = (callback) ->
    # mkdir build dir
    mkdirp build_dir, (err) ->
        if err
            console.error err
            process.exit(code=1)
        else
            build_coffee () ->
                build_copy()
                callback?()

# install: copy files to Extensions directory
install = (callback) ->
    console.log "Copying files to Extensions directory..."

    ncp build_dir, "#{ extensions_dir }/#{ identifier }", (err) ->
        if err
            console.error " > FAILED: #{ err }"
            process.exit(code=1)
        else
            console.log " > DONE"
            callback?()

# archive: create a zip archive from the build
archive = (callback) ->
    console.log "Creating ZIP Archive..."

    zip_file = "#{ identifier.split('.').pop() }.zip"

    # go to build dir
    process.chdir "#{ build_root_dir }/"

    # delete any previous zip
    if fs.existsSync zip_file
        fs.unlinkSync zip_file

    # zip
    zip = exec "zip -r #{ zip_file } #{ identifier }/"
    zip.stderr.on 'data', (data) ->
        process.stderr.write data.toString()
    zip.stdout.on 'data', (data) ->
        process.stdout.write data.toString()
    zip.on 'exit', (code) ->
        if code is 0
            console.log " > DONE"
            callback?()
        else
            console.error " > FAILED: zip returned with error code: #{ code }"
            process.exit(code=code)

# test: run the test suite
test = (callback) ->
    console.log "Building and Running Tests..."

    child = exec "set -o pipefail && xcodebuild test -workspace './test/SwiftAlamofireCodeGenerator.xcworkspace' -scheme SwiftAlamofireCodeGeneratorTests | xcpretty -c"
    child.stderr.on 'data', (data) ->
        process.stderr.write data.toString()
    child.stdout.on 'data', (data) ->
        process.stdout.write data.toString()
    child.on 'exit', (code) ->
        if code is 0
            console.log " > DONE (TESTS SUCCEEDED)"
            callback?()
        else
            console.error " > FAILED: Tests failed with error code #{ code }"
            process.exit(code=code)

# clean: remove any generated file
clean = () ->
    exec "rm -Rf build/"
    exec "rm -Rf node_modules/"
    exec "rm -Rf test/Build/"
    exec "rm -Rf test/DerivedData/"
    exec "rm -Rf test/Podfile.lock/"

task 'build', ->
    build()

task 'test', ->
    test()

task 'install', ->
    build () ->
        install()

task 'archive', ->
    build () ->
        archive()

task 'watch', ->
    # find all files in directory
    for filename in fs.readdirSync '.'
        # only watch non-hidden files
        if not filename.match(/^\./) and fs.lstatSync("./#{ filename }").isFile()
            fs.watchFile "./#{ filename }", {persistent:true, interval:500}, (_event, _filename) ->
                # when a file is changed, build and install
                build () ->
                    install()

task 'clean', ->
    clean()
