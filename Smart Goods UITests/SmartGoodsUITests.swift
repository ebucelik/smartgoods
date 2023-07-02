//
//  SmartGoodsUITests.swift
//  Smart Goods UITests
//
//  Created by Ing. Ebu Celik, BSc on 02.07.23.
//

import XCTest

final class SmartGoodsUITests: XCTestCase {

    func testDeleteRequirement() throws {
        let app = XCUIApplication()
        app.launch()

        // Check if home screen is appearing.
        let homeScreenTitle = app.staticTexts["Smart Goods"]

        XCTAssert(homeScreenTitle.exists)

        // Switch to the create projects tab.
        app.tabBars.buttons.element(boundBy: 1).tap()

        let createProjectTitle = app.staticTexts["Create Project"]

        XCTAssert(createProjectTitle.exists)

        // Create a new project.
        let projectNameTextField = app.textFields["Enter a project name..."]
        projectNameTextField.tap()
        projectNameTextField.typeText("UI Test System")
        projectNameTextField.typeText("\n")

        XCTAssertNotEqual(projectNameTextField.value as? String, "")

        // Save the new project.
        let createProjectButton = app.otherElements["CreateProjectButton"]
        createProjectButton.tap()

        let alreadyCreatedProjectsText = app.staticTexts["ALREADY CREATED PROJECTS"]

        XCTAssert(alreadyCreatedProjectsText.waitForExistence(timeout: 2))

        // Switch to the create requirements tab.
        app.tabBars.buttons.element(boundBy: 2).tap()

        let createRequirementTitle = app.staticTexts["Create Requirement"]

        XCTAssert(createRequirementTitle.exists)

        let createdProjectNameText = app.staticTexts["UI Test System"]

        XCTAssert(createdProjectNameText.exists)

        // Create a new requirement with the new project.
        let processVerbTextField = app.textFields["<process verb>"]
        processVerbTextField.tap()
        processVerbTextField.typeText("perform")
        processVerbTextField.typeText("\n")

        XCTAssertNotEqual(processVerbTextField.value as? String, "")

        let detailsTextField = app.textFields["<details>"]
        detailsTextField.tap()
        detailsTextField.typeText("well with UI Tests")
        detailsTextField.typeText("\n")

        XCTAssertNotEqual(detailsTextField.value as? String, "")

        // Save the new requirement in this project.
        let saveRequirementButton = app.buttons["Save"]
        saveRequirementButton.tap()

        let saveRequirementText = app.staticTexts["Save"]

        XCTAssert(saveRequirementText.waitForExistence(timeout: 10))

        // Switch back to the home screen tab.
        app.tabBars.buttons.element(boundBy: 0).tap()

        XCTAssert(homeScreenTitle.exists)

        // Delete the newly created requirement.
        let deleteRequirementButton = app.otherElements["DeleteRequirementButton"].firstMatch
        deleteRequirementButton.tap()

        let currentlyNoRequirementsAvailableText = app.staticTexts[
            "Currently no requirements for this project available."
        ]

        // Verify that the newly created requirement is deleted.
        XCTAssert(currentlyNoRequirementsAvailableText.waitForExistence(timeout: 2))
    }
}
