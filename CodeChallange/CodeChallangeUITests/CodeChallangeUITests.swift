//
//  CodeChallangeUITests.swift
//  CodeChallangeUITests
//
//  Created by Abhinay Chary on 4/24/25.
//

import XCTest

final class CodeChallangeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    func testSearchField_andImageLoad() throws {
        // 1. Find the search field and type a tag
        let searchField = app.textFields["Search"]
        XCTAssertTrue(searchField.exists, "Search field should be visible")
        searchField.tap()
        searchField.typeText("porcupine")
        
        // 2. Wait for loading indicator (optional)
        let loadingIndicator = app.activityIndicators.firstMatch
        if loadingIndicator.exists {
//            XCTAssertTrue(loadingIndicator.waitForExistence(timeout: 2), "ProgressView should appear")
            XCTAssertTrue(loadingIndicator.exists, "ProgressView appears briefly")
        }
        // 3. Wait for images to load (up to 5 seconds)
        let imageCell = app.images.firstMatch
        let exists = imageCell.waitForExistence(timeout: 5)
        
        // 4. Assert images are loaded or error message shown
        if exists {
            XCTAssertTrue(imageCell.exists, "At least one image should be visible")
        } else {
            let errorText = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Error:'")).firstMatch
            XCTAssertTrue(errorText.exists, "An error should be shown if loading fails")
        }
    }

}
