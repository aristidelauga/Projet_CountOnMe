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

	func testTappedDivisionButtonWithErrorMessage() {
		sut.expression = "5+4"

		sut.tappedDivisionButtonWithErrorMessage {
			print("")
		}

		XCTAssertEqual(sut.expression, "5+4 / ")
	}

	func testTappedMultiplicationButtonWithErrorMessage() {
		sut.expression = "5+4"

		sut.tappedMultiplicationButtonWithErrorMessage {
			print("")
		}

		XCTAssertEqual(sut.expression, "5+4 * ")
	}

	func testTappedAdditionButtonWithErrorMessage() {
		sut.expression = "5+4"

		sut.tappedAdditionButtonWithErrorMessage {
			print("")
		}

		XCTAssertEqual(sut.expression, "5+4 + ")
	}

	func testTappedSubstractionButtonWithErrorMessage() {
		sut.expression = "5+4"

		sut.tappedSubstractionButtonWithErrorMessage {
			print("")
		}

		XCTAssertEqual(sut.expression, "5+4 - ")
	}

	func testTappedEqualButtonWithErrorMessage() {
		sut.expression = "5 + 4 * 5 / 10"
		sut.tappedEqualButtonWithErrorMessage {
			print("")
		}
		XCTAssertEqual(sut.expression, "5 + 4 * 5 / 10 = 7")
	}

	func testInfixToPostfix() {
		let expression = ["5", "4", "5", "*", "10", "/", "+"]
		let infixExpression = ["5", "+", "4", "*", "5", "/", "10"]

		XCTAssertEqual(expression, sut.infixToPostfix(infixExpression))
	}

    func testEvaluatePostfix() {
		let expression = ["5", "4", "5", "*", "10", "/", "+"]
		let result = 7

		let evaluatedPostfix = sut.evaluatePostFix(expression)
		XCTAssertEqual(evaluatedPostfix, result)
	}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
