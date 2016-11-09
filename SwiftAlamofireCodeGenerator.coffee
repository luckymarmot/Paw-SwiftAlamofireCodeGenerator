# in API v0.2.0 and below (Paw 2.2.2 and below), require had no return value
((root) ->
  if root.bundle?.minApiVersion('0.2.0')
    root.URI = require("./URI")
    root.Mustache = require("./mustache")
  else
    require("URI.min.js")
    require("mustache.js")
)(this)

addslashes = (str) ->
    ("#{str}").replace(/[\\"]/g, '\\$&').replace(/[\n\r\f]/gm, '\\n')

slugify = (str) ->
    re = /([a-zA-Z0-9])([a-zA-Z0-9]*)/g
    l = []
    while (m = re.exec(str))
        if (m)
            l.push(m[1].toUpperCase() + m[2].toLowerCase())
    return l.join('')

SwiftAlamofireCodeGenerator = ->
    
    @url = (request) ->
        url_params_object = (() ->
            _uri = URI request.url
            _uri.search true
        )()
        url_params = ({
            "name": addslashes name
            "value": addslashes value
        } for name, value of url_params_object)

        return {
            "fullpath": request.url
            "base": addslashes (() ->
                _uri = URI request.url
                _uri.search("")
                _uri
            )()
            "params": url_params
            "has_params": url_params.length > 0
        }

    @headers = (request) ->
        headers = request.headers
        hasBasicAuth = true if request.httpBasicAuth
        return {
            "has_headers": Object.keys(headers).length > 0
            "header_list": ({
                "header_name": addslashes header_name
                "header_value": addslashes header_value
            } for header_name, header_value of headers when (header_name.toLowerCase() != 'authorization' or not hasBasicAuth))
        }

    @body = (request) ->
        json_body = request.jsonBody
        if json_body
            return {
                "has_json_body":true
                "json_body_object":@json_body_object json_body, 1
            }

        url_encoded_body = request.urlEncodedBody
        if url_encoded_body
            return {
                "has_url_encoded_body":true
                "url_encoded_body": ({
                    "name": addslashes name
                    "value": addslashes value
                } for name, value of url_encoded_body)
            }

        multipart_body = request.multipartBody
        if multipart_body
            return {
                "has_multipart_body":true
                "multipart_body": ({
                    "name": addslashes name
                    "value": addslashes value
                } for name, value of multipart_body)
            }
            
        raw_body = request.body
        if raw_body
            if raw_body.length < 10000
                return {
                    "has_raw_body":true
                    "has_short_body":true
                    "short_body": addslashes raw_body
                }
            else
                return {
                    "has_raw_body":true
                    "has_long_body":true
                }

    @json_body_object = (object, indent = 0) ->
        if object == null
            s = "NSNull()"
        else if typeof(object) == 'string'
            s = "\"#{addslashes object}\""
        else if typeof(object) == 'number'
            s = "#{object}"
        else if typeof(object) == 'boolean'
            s = "#{if object then "true" else "false"}"
        else if typeof(object) == 'object'
            indent_str = Array(indent + 1).join('    ')
            indent_str_children = Array(indent + 2).join('    ')
            if object.length?
                s = "[\n" +
                    ("#{indent_str_children}#{@json_body_object(value, indent+1)}" for value in object).join(',\n') +
                    "\n#{indent_str}]"
            else
                s = "[\n" +
                    ("#{indent_str_children}\"#{addslashes key}\": #{@json_body_object(value, indent+1)}" for key, value of object).join(',\n') +
                    "\n#{indent_str}]"

        if indent <= 1
            s = "let body: [String : Any] = #{s}"

        return s

    @generate = (context) ->
        request = context.getCurrentRequest()
        method = request.method.toUpperCase()

        view =
            "request": request
            "method": method.toLowerCase()
            "url": @url request
            "headers": @headers request
            "body": @body request
            "timeout": if request.timeout then request.timeout / 1000 else null
            "codeSlug": slugify(request.name)
            "httpBasicAuth": request.httpBasicAuth

        view["has_params_to_encode"] = true if view.url.has_params and (method == 'GET' or method == 'HEAD' or method == 'DELETE')

        template = readFile "swift.mustache"
        Mustache.render template, view

    return


SwiftAlamofireCodeGenerator.identifier =
    "com.luckymarmot.PawExtensions.SwiftAlamofireCodeGenerator"
SwiftAlamofireCodeGenerator.title =
    "Swift (Alamofire)"
SwiftAlamofireCodeGenerator.fileExtension = "swift"
SwiftAlamofireCodeGenerator.languageHighlighter = "swift"

registerCodeGenerator SwiftAlamofireCodeGenerator
