//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeUITests: XCTestCase {

	var sut: CountOnMeViewController!

    override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: "CountOnMeViewController") as? CountOnMeViewController
		continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
		sut = nil
		super.tearDown()
    }

    func testDeleteButton() {
		// Given
		sut.computationModel.expression = "5+4*5/10"
		sut.textView.text = "5+4*5/10"

		// When
		let deleteButton = UIButton()
		sut.tappedDeleteButton(deleteButton)

		// Then
		XCTAssertEqual(sut.computationModel.expression, "5+4*5/1")
		XCTAssertEqual(sut.textView.text, "5+4*5/1")

    }

	func testACButton() {
		// Given
		sut.computationModel.expression = "5+4*5/10"
		sut.textView.text = "5+4*5/10"

		// When
		let ACButton = UIButton()
		sut.tappedDeleteButton(ACButton)

		// Then
		XCTAssertEqual(sut.computationModel.expression, "")
		XCTAssertEqual(sut.textView.text, "")

	}

}
