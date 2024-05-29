//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class CountOnMeViewController: UIViewController {

	// MARK: - Variables

    @IBOutlet weak private var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!


    private var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
	private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    }
    
	private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
	private var canAddOperator: Bool {
		return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    }
    
	private var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		textView.text = ""
    }
    
	// MARK: - IBActions method

	@IBAction func tappedACButton(_ sender: UIButton) {
		textView.text = ""
	}

	@IBAction func tappedDeleteButton(_ sender: UIButton) {
		
		if !textView.text.isEmpty {
			textView.text.removeLast()
		}

	}
	

    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }

	@IBAction func tappedDivisionButton(_ sender: UIButton) {
		if canAddOperator {
			textView.text.append(" / ")
		} else {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
	}

	@IBAction func tappedMultiplicationButton(_ sender: UIButton) {
		if canAddOperator {
			textView.text.append(" * ")
		} else {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
	}
	
    @IBAction private func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction private func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
         // Create local copy of operations
		let operationsToReduce = elements

		let postfixExpression = infixToPostfix(elements)
		if let result = evaluatePostfix(postfixExpression) {
			if !expressionHaveResult {
				textView.text.append(" = \(result)")
			}
		} else {
			self.present(UIAlertController(title: "Erreur", message: "Démarrez un nouveau calcul !", preferredStyle: .alert),
						 animated: true,
						 completion: nil)
		}

        if !expressionHaveResult {
        	textView.text.append(" = \(operationsToReduce.first!)")
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

	func evaluatePostfix(_ expression: [String]) -> Int? {
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

