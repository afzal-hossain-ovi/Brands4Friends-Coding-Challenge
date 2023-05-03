//
//  IstGeradeUITests.swift
//  IstGeradeUITests
//
//  Created by Afzal Hossain on 23.03.23.
//

import XCTest

final class IstGeradeUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testEvenListView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // navigaiton title
        let appTitle = app.staticTexts["IstGerade"]
        XCTAssert(appTitle.exists)
        XCTAssertEqual(appTitle.label, "IstGerade")
        
        // number textFields
        let numberTxtFld = app.textFields["number_text_field"]
        XCTAssert(numberTxtFld.exists)
        numberTxtFld.tap()
        numberTxtFld.typeText("6")
        
        // send button
        let sendButton = app.buttons["send_button"]
        XCTAssert(sendButton.exists)
        XCTAssertEqual(sendButton.label, "Ist diese Zahl gerade?")
        sendButton.tap()
        
        // popup close button
        let closeButton = app.buttons["close_button"]
        closeButton.tap()
        
        // list
        let resultList = app.otherElements["result_list"]
        XCTAssertFalse(resultList.waitForExistence(timeout: 2))
    }
}
