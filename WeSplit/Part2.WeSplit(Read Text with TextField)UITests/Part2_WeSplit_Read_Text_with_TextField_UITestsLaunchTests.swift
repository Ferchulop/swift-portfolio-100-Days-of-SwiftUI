//
//  Part2_WeSplit_Read_Text_with_TextField_UITestsLaunchTests.swift
//  Part2.WeSplit(Read Text with TextField)UITests
//
//  Created by Fernando Jurado on 9/7/24.
//

import XCTest

final class Part2_WeSplit_Read_Text_with_TextField_UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
