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

class SwiftAlamofireCodeGeneratorTests: XCTestCase {
	
    func testExample() {
        // This is an example of a functional test case.
		Alamofire.request(.GET, "http://httpbin.org/get")
			.responseString { (_, _, string, _) in
				println(string)
				XCTAssert(true, "Pass")
		}
    }
    
}