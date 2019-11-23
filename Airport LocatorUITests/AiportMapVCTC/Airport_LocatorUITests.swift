//
//  Airport_LocatorUITests.swift
//  Airport LocatorUITests
//
//  Created by Mohd Taha on 19/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import XCTest

class Airport_LocatorUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAiroportMapVC() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.navigationBars["Airport Locator"].buttons["Refresh"].tap()
        app.buttons["icLocation"].tap()
        
        let map = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .map).element
        map.swipeUp()
        map.tap()
        map.tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
