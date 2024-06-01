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
// TODO: Détecter quel bouton a ete tape dans le view controller puis décider dans le modele
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
	let computationModel = ComputationModel()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.computationModel.delegate = self
		computationModel.cleanText()
    }
    
	// MARK: - IBActions method

	@IBAction func tappedACButton(_ sender: UIButton) {
		computationModel.cleanText()
	}

	@IBAction func tappedDeleteButton(_ sender: UIButton) {
		if !computationModel.expression.isEmpty {
			computationModel.expression.removeLast()
		}
	}
	

    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
		computationModel.tappedNumberButton(numberText: numberText)
    }

	@IBAction func tappedDivisionButton(_ sender: UIButton) {
		computationModel.tappedDivisionButtonWithErrorMessage {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
	}

	@IBAction func tappedMultiplicationButton(_ sender: UIButton) {
		computationModel.tappedMultiplicationButtonWithErrorMessage {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)

		}
	}
	
    @IBAction private func tappedAdditionButton(_ sender: UIButton) {
		computationModel.tappedAdditionButtonWithErrorMessage {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
    }
    
    @IBAction private func tappedSubstractionButton(_ sender: UIButton) {
		computationModel.tappedSubstractionButtonWithErrorMessage {
			let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
    }

    @IBAction private func tappedEqualButton(_ sender: UIButton) {
		guard computationModel.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
		guard computationModel.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }

		computationModel.tappedEqualButtonWithErrorMessage {
			self.present(UIAlertController(title: "Erreur", message: "Démarrez un nouveau calcul !", preferredStyle: .alert),
						 animated: true,
						 completion: nil)
		}
    }

	func infixToPostfix(_ expression: [String]) -> [String] {
		computationModel.infixToPostfix(expression)
	}

	func evaluatePostfix(_ expression: [String]) -> Int? {
		computationModel.evaluatePostFix(expression)
	}
}

extension CountOnMeViewController: ComputationModelDelegate {
	func getTextView(value: String) {
		self.textView.text = value
	}
}
