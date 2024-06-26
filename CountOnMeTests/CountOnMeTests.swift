//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

	private var sut: ComputationModel!
	override func setUp() {
		super.setUp()
		sut = ComputationModel()
	}

	override func tearDown() {
		sut = nil
		super.tearDown()
	}

	func testCleanText() {
		sut.expression = "5+4*5/10"
		let emptyExpression = ""

		sut.cleanText()
		XCTAssertEqual(sut.expression, emptyExpression)
	}

	func testTappedDeleteButton() {
		sut.expression = "5+4*5/10"
		let partiallyDeletedExpression = "5+4*5/1"

		sut.tappedDeleteButton()
		XCTAssertEqual(sut.expression, partiallyDeletedExpression)
	}

	func testTappedNumberButton() {
		sut.tappedNumberButton(numberText: "7")

		XCTAssertTrue(sut.expression == "7")
	}

	func testTappedDivisionButton() {
		sut.expression = "5+4"
		sut.tappedDivisionButton()
		XCTAssertEqual(sut.expression, "5+4 / ")
	}

	func testTappedMultiplicationButton() {
		sut.expression = "5+4"
		sut.tappedMultiplicationButton()
		XCTAssertEqual(sut.expression, "5+4 * ")
	}

	func testTappedAdditionButton() {
		sut.expression = "5+4"
		sut.tappedAdditionButton()
		XCTAssertEqual(sut.expression, "5+4 + ")
	}

	func testTappedSubstractionButton() {
		sut.expression = "5+4"
		sut.tappedSubstractionButton()
		XCTAssertEqual(sut.expression, "5+4 - ")
	}

	func testTappedEqualButton() {
		sut.expression = "5 + 4 * 5 / 10"
		sut.tappedEqualButton()
		XCTAssertEqual(sut.expression, "5 + 4 * 5 / 10 = 7")
	}	
}
