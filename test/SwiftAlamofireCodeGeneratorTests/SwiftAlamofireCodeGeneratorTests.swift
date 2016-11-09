//
//  SwiftAlamofireCodeGeneratorTests.swift
//  SwiftAlamofireCodeGeneratorTests
//
//  Created by Quentin Rousseau on 2/16/15.
//  Copyright (c) 2015 Quentin Rousseau. All rights reserved.
//

import Cocoa
import XCTest
import Alamofire

class SwiftAlamofireCodeGeneratorTests: XCTestCase
{
    func testGETRequest()
	{
        // My API (GET http://echo.luckymarmot.com/)
        
        // Add timeout
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 2
        let manager = Alamofire.SessionManager(configuration: configuration)
        
        // Add Headers
        manager.session.configuration.httpAdditionalHeaders = [
            "oaief":"oinef",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
        ]
        
        // Add parameters
        let URLParameters = [
            "afjkb":"kjabef",
        ]
        
        // Fetch Request
        Alamofire.request("http://echo.luckymarmot.com/", method: .get, parameters: URLParameters)
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                if (response.result.error == nil)
                {
                    print("HTTP Response Body: \(response.data)")
                }
                else
                {
                    print("HTTP Request failed: \(response.result.error)")
                }
        }


	}
	
	func testPOSTJSONRequest()
	{
        // My API (POST http://echo.luckymarmot.com/)
        
        // Create manager
        let manager = Alamofire.SessionManager.default
        
        // Add Headers
        manager.session.configuration.httpAdditionalHeaders = [
            "aeufb":"oubeaf",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
            "Content-Type":"application/json",
        ]
        
        // JSON Body
        let bodyParameters = [
            "alfekjn": "ljafel",
            "ljaebf": "ljbaeflj",
            "baef": "caboue"
        ]
        
        
        let encoding = JSONEncoding.default
        
        // Fetch Request
        Alamofire.request("http://echo.luckymarmot.com", method: .post, parameters: bodyParameters, encoding: encoding)
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                if (response.result.error == nil)
                {
                    print("HTTP Response Body: \(response.data)")
                }
                else
                {
                    print("HTTP Request failed: \(response.result.error)")
                }
        }
	}
	
	func testPOSTTextRequest()
	{
        // My API (POST http://echo.luckymarmot.com/)
        
        // Create manager
        var manager = Alamofire.SessionManager.default
        
        // Add Headers
        manager.session.configuration.httpAdditionalHeaders = [
            "aeufb":"oubeaf",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
            "Content-Type":"application/json",
        ]
        
        // Add timeout
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        manager = Alamofire.SessionManager(configuration: configuration)
        
        // Add Headers
        manager.session.configuration.httpAdditionalHeaders = [
            "aefoib":"eiubef",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
        ]
        Alamofire.request(urlRequestWithRawBody("http://echo.luckymarmot.com", rawBody: "azdouaeifub"))
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                if (response.result.error == nil)
                {
                    print("HTTP Response Body: \(response.data)")
                }
                else
                {
                    print("HTTP Request failed: \(response.result.error)")
                }
        }
	}
	
	func testPOSTFormEncodedURLRequest()
	{
		// POST Form URL-Encoded (POST http://httpbin.org/post)
		
		// Create manager
        let manager = Alamofire.SessionManager.default
        
        // Add Headers
        manager.session.configuration.httpAdditionalHeaders = [
            "aeufb":"oubeaf",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
            "Content-Type":"application/json",
        ]
		
		// Form URL-Encoded Body
		let bodyParameters = [
			"form-nonce-key":"nCjEgdfF5Hj41WssKwuok7d0VwMKoQrC",
			"form-date-key":"Tue, 17 Feb 2015 19:42:28 GMT",
			"form-key1":"form-value1",
			"form-key2":"form-value2",
		]
		let encoding = URLEncoding.default
		//NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://httpbin.org/post" parameters:bodyParameters error:nil];
		
		// Fetch Request
        Alamofire.request("http://httpbin.org/post", method: .post, parameters: bodyParameters, encoding: encoding)
			.validate(statusCode: 200..<300)
            .responseJSON{(response) in
                if (response.result.error == nil)
                {
                    print("HTTP Response Body: \(response.data)")
                }
                else
                {
                    print("HTTP Request failed: \(response.result.error)")
                }
        }
	}

	func testPOSTMultipartRequest()
	{
        // Create manager
        let manager = Alamofire.SessionManager.default
        
        // Add Headers
        manager.session.configuration.httpAdditionalHeaders = [
            "aieufb":"iubaef",
        ]
        
		// POST Multipart (POST http://httpbin.org/post)
		
		// Form Multipart Body
        let bodyParameters: NSDictionary = [
			"multipart-key2":"multipart-value2",
			"multipart-key1":"multipart-value1",
			"multipart-date-key":"Tue, 17 Feb 2015 21:45:59 GMT",
			"multipart-nonce-key":"mnrkAaYqhh7UNivNmYVdFwiqmk8Ms5fa",
		]
		
		Alamofire.request(urlRequestWithMultipartBody("http://httpbin.org/post?toto=toto", parameters: bodyParameters))
			.validate(statusCode: 200..<300)
        // Add Headers
        manager.session.configuration.httpAdditionalHeaders = [
            "aeufb":"oubeaf",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
            "Content-Type":"application/json",
        ]
	}
	
	func urlRequestWithRawBody(_ urlString:String, rawBody:String) -> (URLRequestConvertible) {

		// Create url request to send
		var mutableURLRequest = URLRequest(url: URL(string: urlString)!)
		mutableURLRequest.httpMethod = HTTPMethod.post.rawValue
		
		// Set content-type
		mutableURLRequest.setValue("", forHTTPHeaderField: "Content-Type")
		
		// Set the HTTPBody we'd like to submit
		let requestBodyData = NSMutableData()
		requestBodyData.append(rawBody.data(using: String.Encoding.utf8)!)
		
		mutableURLRequest.httpBody = requestBodyData as Data

		// return URLRequestConvertible
		return try! (URLEncoding.default.encode(mutableURLRequest, with: nil))
	}
	
	func urlRequestWithMultipartBody(_ urlString:String, parameters:NSDictionary) -> (URLRequestConvertible) {

		// create url request to send
		var mutableURLRequest = URLRequest(url: URL(string: urlString)!)
		mutableURLRequest.httpMethod = HTTPMethod.post.rawValue
		// Set Content-Type in HTTP header.
		let boundary = "PAW-boundary-\(arc4random())-\(arc4random())"
		let contentType = "multipart/form-data; boundary=" + boundary
		
		// Set data
		var dataString = String()
		dataString += "--\(boundary)"
		for (key, value) in parameters { dataString += "\r\nContent-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)\r\n--\(boundary)" }
		dataString += "--"

		// Set content-type
		mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
		
		// Set the HTTPBody we'd like to submit
		let requestBodyData = (dataString as NSString).data(using: String.Encoding.utf8.rawValue)
		mutableURLRequest.httpBody = requestBodyData

		// return URLRequestConvertible
		return try! (URLEncoding.default.encode(mutableURLRequest, with: nil))
	}
    
    
    // MARK:- Alamofire 4 + Swift 3 Tests
    
    func testTextGeneratedRequest() {
        /**
         Documentation
         post https://echo.paw.cloud/
         */
        
        // Add Headers
        let headers = [
            "Some-Header-X":"X-Value",
            "Cookie":"sessionid=dn8ik4sd2sw0k9ayoi11irj6x2ibbkfl",
            "Content-Type":"text/plain; charset=utf-8",
            ]
        
        // Custom Body Encoding
        struct RawDataEncoding: ParameterEncoding {
            public static var `default`: RawDataEncoding { return RawDataEncoding() }
            public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
                var request = try urlRequest.asURLRequest()
                request.httpBody = "{\n  \"id\": \"12\",\n  \"list\": [\n    \"123\",\n    \"456\"\n  ]\n}".data(using: String.Encoding.utf8, allowLossyConversion: false)
                return request
            }
        }
        
        // Fetch Request
        Alamofire.request("https://echo.paw.cloud/?Some-Param=yeah&Other-Param=", method: .post, encoding: RawDataEncoding.default, headers: headers)
            .authenticate(user: "user", password: "***** Hidden credentials *****")
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
    
    func testJSONGeneratedRequest() {
        /**
         Documentation
         post https://echo.paw.cloud/
         */
        
        // Add Headers
        let headers = [
            "Some-Header-X":"X-Value",
            "Cookie":"sessionid=dn8ik4sd2sw0k9ayoi11irj6x2ibbkfl",
            "Content-Type":"application/json; charset=utf-8",
            ]
        
        // JSON Body
        let body: [String : Any] = [
            "id": "12",
            "list": [
                "123",
                "456"
            ]
        ]
        
        struct RawDataEncoding: ParameterEncoding {
            public static var `default`: RawDataEncoding { return RawDataEncoding() }
            public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
                var request = try urlRequest.asURLRequest()
                request.httpBody = "{\n  \"id\": \"12\",\n  \"list\": [\n    \"123\",\n    \"456\"\n  ]\n}".data(using: String.Encoding.utf8, allowLossyConversion: false)
                return request
            }
        }
        
        // Fetch Request
        Alamofire.request("https://echo.paw.cloud/?Some-Param=yeah&Other-Param=", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .authenticate(user: "user", password: "***** Hidden credentials *****")
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
    
    func testFormURLEncodedGeneratedRequest() {
        /**
         Documentation
         post https://echo.paw.cloud/
         */
        
        // Add Headers
        let headers = [
            "Some-Header-X":"X-Value",
            "Cookie":"sessionid=dn8ik4sd2sw0k9ayoi11irj6x2ibbkfl",
            "Content-Type":"application/x-www-form-urlencoded; charset=utf-8",
            ]
        
        // Form URL-Encoded Body
        let body = [
            "d":"a",
            ]
        
        // Fetch Request
        Alamofire.request("https://echo.paw.cloud/?Some-Param=yeah&Other-Param=", method: .post, parameters: body, encoding: URLEncoding.default, headers: headers)
            .authenticate(user: "user", password: "***** Hidden credentials *****")
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
    
    func testMultipartGeneratedRequest() {
        /**
         Documentation
         post https://echo.paw.cloud/
         */
        
        // Add Headers
        let headers = [
            "Some-Header-X":"X-Value",
            "Cookie":"sessionid=dn8ik4sd2sw0k9ayoi11irj6x2ibbkfl",
            "Content-Type":"multipart/form-data; charset=utf-8; boundary=__X_PAW_BOUNDARY__",
            ]
        
        // Fetch Request
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append("a".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"d")
        }, usingThreshold: UInt64.init(), to: "https://echo.paw.cloud/?Some-Param=yeah&Other-Param=", method: .post, headers: headers, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    // FIXME: custom encoding
    
    func testFileGeneratedRequest() {
        /**
         Documentation
         post https://echo.paw.cloud/
         */
        
        // Add Headers
        let headers = [
            "Some-Header-X":"X-Value",
            "Cookie":"sessionid=dn8ik4sd2sw0k9ayoi11irj6x2ibbkfl",
            "Content-Type":"text/plain",
            ]
        
        // Custom Body Encoding
        struct RawDataEncoding: ParameterEncoding {
            public static var `default`: RawDataEncoding { return RawDataEncoding() }
            public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
                var request = try urlRequest.asURLRequest()
                request.httpBody = nil // set your body data here
                return request
            }
        }
        
        // Fetch Request
        Alamofire.request("https://echo.paw.cloud/?Some-Param=yeah&Other-Param=", method: .post, encoding: RawDataEncoding.default, headers: headers)
            .authenticate(user: "user", password: "***** Hidden credentials *****")
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
	
}
