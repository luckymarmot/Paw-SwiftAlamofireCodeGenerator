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
        
        // Create manager
        var manager = Manager.sharedInstance
        
        // Add timeout
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 2
        manager = Alamofire.Manager(configuration: configuration)
        
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
            "oaief":"oinef",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
        ]
        
        // Add parameters
        let URLParameters = [
            "afjkb":"kjabef",
        ]
        
        // Fetch Request
        Alamofire.request(.GET, "http://echo.luckymarmot.com/", parameters: URLParameters)
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
        let manager = Manager.sharedInstance
        
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
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
        
        let encoding = Alamofire.ParameterEncoding.JSON
        
        // Fetch Request
        Alamofire.request(.POST, "http://echo.luckymarmot.com", parameters: bodyParameters, encoding: encoding)
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
        var manager = Manager.sharedInstance
        
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
            "aeufb":"oubeaf",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
            "Content-Type":"application/json",
        ]
        
        // Add timeout
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 5
        manager = Alamofire.Manager(configuration: configuration)
        
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
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
		let manager = Manager.sharedInstance
		
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
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
		let encoding = Alamofire.ParameterEncoding.URL
		//NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://httpbin.org/post" parameters:bodyParameters error:nil];
		
		// Fetch Request
		Alamofire.request(.POST, "http://httpbin.org/post", parameters: bodyParameters, encoding: encoding)
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
        let manager = Manager.sharedInstance
        
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
            "aieufb":"iubaef",
        ]
        
		// POST Multipart (POST http://httpbin.org/post)
		
		// Form Multipart Body
		let bodyParameters = [
			"multipart-key2":"multipart-value2",
			"multipart-key1":"multipart-value1",
			"multipart-date-key":"Tue, 17 Feb 2015 21:45:59 GMT",
			"multipart-nonce-key":"mnrkAaYqhh7UNivNmYVdFwiqmk8Ms5fa",
		]
		
		Alamofire.request(urlRequestWithMultipartBody("http://httpbin.org/post?toto=toto", parameters: bodyParameters))
			.validate(statusCode: 200..<300)
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
            "aeufb":"oubeaf",
            "Cookie":"sessionid=j9z27n2m0wptpuk6xcbjiov86f7pyrjm",
            "Content-Type":"application/json",
        ]
	}
	
	func urlRequestWithRawBody(urlString:String, rawBody:String) -> (URLRequestConvertible) {

		// Create url request to send
		let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
		mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
		
		// Set content-type
		mutableURLRequest.setValue("", forHTTPHeaderField: "Content-Type")
		
		// Set the HTTPBody we'd like to submit
		let requestBodyData = NSMutableData()
		requestBodyData.appendData(rawBody.dataUsingEncoding(NSUTF8StringEncoding)!)
		
		mutableURLRequest.HTTPBody = requestBodyData

		// return URLRequestConvertible
		return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0)
	}
	
	func urlRequestWithMultipartBody(urlString:String, parameters:NSDictionary) -> (URLRequestConvertible) {

		// create url request to send
		let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
		mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
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
		let requestBodyData = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
		mutableURLRequest.HTTPBody = requestBodyData

		// return URLRequestConvertible
		return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0)
	}
	
}