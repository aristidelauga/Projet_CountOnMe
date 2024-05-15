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
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            var result: Int = 0
            switch operand {
			case "/": result = left / right
			case "*": result = left * right
            case "+": result = left + right
            case "-": result = left - right
            default: break
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        if !expressionHaveResult {
        	textView.text.append(" = \(operationsToReduce.first!)")
        }
    }

}

