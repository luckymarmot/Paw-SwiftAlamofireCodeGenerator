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
		let expectation = expectationWithDescription("request sent")

		// GET (Headers & URL Params) (GET http://httpbin.org/get)

		// Create manager
		var manager = Manager.sharedInstance

		// Add Headers
		manager.session.configuration.HTTPAdditionalHeaders = [
			"X-Special-Header":"JytsL82VnKSJr6nFXgbTv7LqYjHi2ndo",
			"Content-Type":"application/json",
		]

		let URLParameters = [
			"param1":"value1",
			"param2":"value2",
		]
		
		// Fetch Request
		Alamofire.request(.GET, "http://httpbin.org/get", parameters: URLParameters)
		.validate(statusCode: 200..<300)
		.responseJSON{(request, response, JSON, error) in
			if (error == nil)
			{
				println("HTTP Response Body: \(JSON)")
			}
			else
			{
				println("HTTP HTTP Request failed: \(error)")
			}
			expectation.fulfill()
			XCTAssertNotNil(JSON, "data should not be nil")
			XCTAssertNotNil(response, "response should not be nil")
			XCTAssertNil(error, "error should be nil")
		}

		waitForExpectationsWithTimeout(5, nil)
	}
	
	func testPOSTJSONRequest()
	{
		let expectation = expectationWithDescription("request sent")
		
		// POST JSON Body (POST http://httpbin.org/post)
		
		// Create manager
		var manager = Manager.sharedInstance
		
		// Add Headers
		manager.session.configuration.HTTPAdditionalHeaders = [
			"X-Special-Header":"sdfsadf",
		]
		
		// JSON Body
		let bodyParameters = [
			"asdfasf": 42.1123,
			"asdf": "asdf",
			"sadffasdasdfsadf": true,
			"asdfasd": NSNull(),
			"asdfasdfasdf": "ssadfasdfsdf",
			"asdfasdasd": [
				"asdf",
				"asdfasdf"
			],
			"sadfasdf": "asdfsasadfasdfdf",
			"sdfasdf": false
		]
		
		let encoding = Alamofire.ParameterEncoding.JSON
		
		// Fetch Request
		Alamofire.request(.POST, "http://httpbin.org/post?toto=toto", parameters: bodyParameters, encoding: encoding)
			.validate(statusCode: 200..<300)
			.responseJSON{(request, response, JSON, error) in
				if (error == nil)
				{
					println("HTTP Response Body: \(JSON)")
				}
				else
				{
					println("HTTP HTTP Request failed: \(error)")
				}
				expectation.fulfill()
				XCTAssertNotNil(JSON, "data should not be nil")
				XCTAssertNotNil(response, "response should not be nil")
				XCTAssertNil(error, "error should be nil")
		}
		
		waitForExpectationsWithTimeout(5, nil)
	}
	
	func testPOSTTextRequest()
	{
		let expectation = expectationWithDescription("request sent")

		// POST Text Body (POST http://httpbin.org/post)
		
		Alamofire.request(urlRequestWithRawBody("http://httpbin.org/post?toto=toto", rawBody: "Some text body"))
			.validate(statusCode: 200..<300)
			.responseJSON{(request, response, JSON, error) in
				if (error == nil)
				{
					println("HTTP Response Body: \(JSON)")
				}
				else
				{
					println("HTTP HTTP Request failed: \(error)")
				}
				expectation.fulfill()
				XCTAssertNotNil(JSON, "data should not be nil")
				XCTAssertNotNil(response, "response should not be nil")
				XCTAssertNil(error, "error should be nil")
		}
		
		waitForExpectationsWithTimeout(5, nil)
	}
	
	func testPOSTFormEncodedURLRequest()
	{
		let expectation = expectationWithDescription("request sent")
		
		// POST Form URL-Encoded (POST http://httpbin.org/post)
		
		// Create manager
		var manager = Manager.sharedInstance
		
		
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
			.responseJSON{(request, response, JSON, error) in
				if (error == nil)
				{
					println("HTTP Response Body: \(JSON)")
				}
				else
				{
					println("HTTP HTTP Request failed: \(error)")
				}
				expectation.fulfill()
				XCTAssertNotNil(JSON, "data should not be nil")
				XCTAssertNotNil(response, "response should not be nil")
				XCTAssertNil(error, "error should be nil")
		}
		
		waitForExpectationsWithTimeout(5, nil)
	}

	func testPOSTMultipartRequest()
	{
		let expectation = expectationWithDescription("request sent")
		
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
			.responseJSON{(request, response, JSON, error) in
				if (error == nil)
				{
					println("HTTP Response Body: \(JSON)")
				}
				else
				{
					println("HTTP HTTP Request failed: \(error)")
				}
				expectation.fulfill()
				XCTAssertNotNil(JSON, "data should not be nil")
				XCTAssertNotNil(response, "response should not be nil")
				XCTAssertNil(error, "error should be nil")
		}
		
		waitForExpectationsWithTimeout(5, nil)
	}
	
	func urlRequestWithRawBody(urlString:String, rawBody:String) -> (URLRequestConvertible) {

		// Create url request to send
		var mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
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
		var mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
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