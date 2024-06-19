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

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//		let baseExpression = "(((((((((((((((((((((((((5 + (((4 * 5) / 10))) + 5000) + (92 * 75)) - (820 / 2)) + (45 * 12)) - 150) + 42) + (((7 * 2) / 3) + 5) * (18 / 3)) + 200) - (32 / 4)) + (64 * 8)) / 512) + (20 / 10)) - 8) + (3 * 6) - (5 / 3) * 25) + 1000) / 500) + (600 / 3)) - (750 * 5)) + (40 / 20)) * (33 / 11) + 15) - (99 * 3)) + (44 / 2)) - 150) + 200) - (65 * 5) + (8 * 10) + ((3 * 4) + (5 / 2) - 9 + (7 * 2)) / (88 / 4)) - (15 * 5)) + 75) + 110) - (23 / 2) + ((60 / 10) * (14 / 7) - 90) + (20 * 2) - (50 / 5) + 100) / 25) + (4 * 4) - (8 * 2) + (3 / 5) * 7) - (7 / 3) + 6) * (14 / 7) + (2 / 1) - (20 / 10) + (30 * 6) - 100) + (50 / 5) + 300) * 15) - (3 * 3) + 45) - (22 / 2) + 150) * 2) + 35) - (7 / 4) + (60 * 3) - 250) + (30 / 10) - (33 * 3) + 10) / 2) + 100) + 200) / 4)"
//		sut.expression = "(((((((((((((((((((((((((5 + (((4 * 5) / 10))) + 5000) + (92 * 75)) - (820 / 2)) + (45 * 12)) - 150) + 42) + (((7 * 2) / 3) + 5) * (18 / 3)) + 200) - (32 / 4)) + (64 * 8)) / 512) + (20 / 10)) - 8) + (3 * 6) - (5 / 3) * 25) + 1000) / 500) + (600 / 3)) - (750 * 5)) + (40 / 20)) * (33 / 11) + 15) - (99 * 3)) + (44 / 2)) - 150) + 200) - (65 * 5) + (8 * 10) + ((3 * 4) + (5 / 2) - 9 + (7 * 2)) / (88 / 4)) - (15 * 5)) + 75) + 110) - (23 / 2) + ((60 / 10) * (14 / 7) - 90) + (20 * 2) - (50 / 5) + 100) / 25) + (4 * 4) - (8 * 2) + (3 / 5) * 7) - (7 / 3) + 6) * (14 / 7) + (2 / 1) - (20 / 10) + (30 * 6) - 100) + (50 / 5) + 300) * 15) - (3 * 3) + 45) - (22 / 2) + 150) * 2) + 35) - (7 / 4) + (60 * 3) - 250) + (30 / 10) - (33 * 3) + 10) / 2) + 100) + 200) / 4)"
//		let result = 352243
//        self.measure {
//			sut.tappedDeleteButton()
//			XCTAssertEqual(sut.expression, baseExpression + " = \(result)")
//        }
//    }
//
}
