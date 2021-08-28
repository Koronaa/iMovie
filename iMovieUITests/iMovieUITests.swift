//
//  iMovieUITests.swift
//  iMovieUITests
//
//  Created by Sajith Konara on 2021-08-22.
//

import XCTest

class iMovieUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    private func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 5) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.record(XCTIssue(type: .assertionFailure, compactDescription: message))
            }
        }
    }
    
    
    
    func testUINavigation(){
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.element(boundBy: 2).tap()
        let collectionView = app.collectionViews.firstMatch
        self.waitForElementToAppear(element: collectionView, timeout: 10.0)
        app.tables.cells.element(boundBy: 0).swipeUp()
        collectionView.cells.element(boundBy: 2).tap()
        sleep(3)
    }
}
