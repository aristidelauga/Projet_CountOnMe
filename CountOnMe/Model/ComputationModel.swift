//
//  ComputationModel.swift
//  CountOnMe
//
//  Created by Aristide LAUGA on 09/05/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol ComputationModelDelegate {
	func getTextView(value: String)
}


final class ComputationModel {

	var delegate: ComputationModelDelegate?

	var expression = "" {
		didSet {
			delegate?.getTextView(value: expression)
		}
	}

	var elements: [String] {
		expression.split(separator: " ").map { "\($0)" }
	}

	// Error check computed variables
	var expressionIsCorrect: Bool {
		return self.elements.last != "+" && self.elements.last != "-" && self.elements.last != "/" && self.elements.last != "*"
	}

	var expressionHaveEnoughElement: Bool {
		return self.elements.count >= 3
	}

	var canAddOperator: Bool {
		return self.elements.last != "+" && self.elements.last != "-" && self.elements.last != "/" && self.elements.last != "*"
	}

	var expressionHaveResult: Bool {
		return expression.firstIndex(of: "=") != nil
	}

	func cleanText() {
		self.expression = ""
	}

	func tappedDeleteButton() {
		if !expression.isEmpty {
			expression.removeLast()
		}
	}

	func tappedNumberButton(numberText: String) {
		if expressionHaveResult {
			cleanText()
		}
		expression.append(numberText)
	}

	func tappedDivisionButtonWithErrorMessage(_ UIHandler: () -> Void) {
		if canAddOperator {
			self.expression.append(" / ")
		} else {
			UIHandler()
		}
	}

	func tappedMultiplicationButtonWithErrorMessage(_ UIHandler: () -> Void) {
		if canAddOperator {
			self.expression.append(" * ")
		} else {
			UIHandler()
		}
	}

	func tappedAdditionButtonWithErrorMessage(_ UIHandler: () -> Void) {
		if canAddOperator {
			self.expression.append(" + ")
		} else {
			UIHandler()
		}
	}

	func tappedSubstractionButtonWithErrorMessage(_ UIHandler: () -> Void) {
		if canAddOperator {
			self.expression.append(" - ")
		} else {
			UIHandler()
		}
	}

	func tappedEqualButtonWithErrorMessage(_ UIHandler: () -> Void) {
		// Create local copy of operations
		let operationsToReduce = elements
		let postfixExpression = infixToPostfix(elements)
		
		if let result = evaluatePostFix(postfixExpression) {
			if !expressionHaveResult {
				expression.append(" = \(result)")
			} else { 
				UIHandler()
			}
		}
	}

	func infixToPostfix(_ expression: [String]) -> [String] {

		var output: [String] = []
		var operandsStack: [String] = []

		let precedence: [String: Int] = ["+": 1, "-": 1, "*": 2, "/": 2]

		for element in expression {
			// If the element is an integer, it's added to the output's array

			if let _ = Int(element) {
				output.append(element)
				//			if element is Int
			} else if let precedenceOfElement = precedence[element] {
				while let last = operandsStack.last, let precedenceOfLast = precedence[last], precedenceOfLast >= precedenceOfElement {
					// Removes the last element of `operandsStack` and adds it at the end of `output`
					output.append(operandsStack.popLast()!)
				}
				// If the element is a sign symbol, it is added to the operandsStack
				operandsStack.append(element)
			}
		}


		// Removes every element of `operandsStack` one by one and add them to `output` at the same time
		while let last = operandsStack.popLast() {
			output.append(last)
		}
		return output
	}

	func evaluatePostFix(_ expression: [String]) -> Int? {
		var stack: [Int] = []

		for element in expression {
			if let number = Int(element) {
				stack.append(number)
			} else if element == "+" || element == "-" || element == "*" || element == "/" {
				guard stack.count >= 2 else { return nil }
				// Last element of the postfix expression
				let right = stack.popLast()!
				// Second last element of the postfix expression
				let left = stack.popLast()!
				var result: Int
				switch element {
					case "+": result = left + right
					case "-": result = left - right
					case "*": result = left * right
					case "/": result = left / right
					default: return nil
				}
				stack.append(result)
			}
		}
		return stack.last
	}
}
