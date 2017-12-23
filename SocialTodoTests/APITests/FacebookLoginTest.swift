//
//  FacebookLoginTest.swift
//  SocialTodoTests
//
//  Created by Brannen Hall on 17-12-18.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import XCTest
import FacebookCore
import FacebookLogin

class FacebookLoginTest: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIApplication.shared.delegate.logout()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    UIApplication.shared.delegate.login()
  }

  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssert(AccessToken.current != nil)
    UIApplication.shared.delegate.logout()
    XCTAssert(AccessToken.current == nil)
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
