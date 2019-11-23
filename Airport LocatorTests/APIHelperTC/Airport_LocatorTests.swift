//
//  Airport_LocatorTests.swift
//  Airport LocatorTests
//
//  Created by Mohd Taha on 19/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import XCTest
import MapKit
@testable import Airport_Locator

class Airport_LocatorTests: XCTestCase {

    var sutAPIHelper: APIHelper!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sutAPIHelper = APIHelper()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sutAPIHelper = nil
        super.tearDown()
    }
    
    func getSUTApiHelper() -> APIHelper {
        return sutAPIHelper
    }
    
    func testValidCallToMapsAPI() {
        let promise = expectation(description: "Result Received")
        
        let _ = sutAPIHelper.getSearchResult(key: GlobalConstants.airportKey, inRegion: MKCoordinateRegion()) { (result) in
            let count = result.count
            if count > 0 {
                promise.fulfill()
            } else {
                XCTFail("Error no result")
                return
            }
        }
        wait(for: [promise], timeout: 5)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
