//
//  ErrorHelperTests.swift
//  GoJekContactsTests
//
//  Created by K.Dheerasameer on 6/13/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import XCTest
@testable import GoJekContacts

class ErrorHelperTests: XCTestCase {
  
  var errorType: ErrorType? = nil
  var response: URLResponse? = nil
  
  override func setUp() {
    super.setUp()
    errorType = ErrorType.JsonSerialization
    response = HTTPURLResponse(url: URL(string: "www.sample.com")!, statusCode: 202, httpVersion: "", headerFields: nil)
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    errorType = nil
  }
  
  func testGetError() {
    let error = ErrorHelper.getError(type: errorType!)
    XCTAssertEqual(error.localizedDescription, errorType?.getDescription())
  }
  
  func testGetErrorForResponse() {
    let error = ErrorHelper.getErrorForResponse(response!)
    XCTAssert( error != nil && error.localizedDescription != "")
  }
  
}
