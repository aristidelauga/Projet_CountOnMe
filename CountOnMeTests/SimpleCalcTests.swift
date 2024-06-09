//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

	private var sut: ComputationModel!
    override func setUp() {
		sut = ComputationModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
		let expression = ["5", "4", "*", "10", "/", "+"]
		let result = 7

//		let infixToPostfix = sut.infixToPostfix(expression.split(separator: " ").map { "\($0)" })
		let evaluatedPostfix = sut.evaluatePostFix(expression)
		print(evaluatedPostfix)
		XCTAssertEqual(evaluatedPostfix, result)
	}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
