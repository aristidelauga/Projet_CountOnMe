//
//  AlertError.swift
//  CountOnMe
//
//  Created by Aristide LAUGA on 19/06/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum AlertError: Error {
	case dividedByZero

	var title: String {
		switch self {
			case .dividedByZero:
				"Zéro"
		}
	}

	var message: String {
		switch self {
			case .dividedByZero:
				"Vous ne pouvez pas diviser par zéro !"
		}
	}

	enum ErrorTitle {
		static let zeroError = "Zéro"
		static let error = "Erreur"
	}

	enum ErrorMessage {
		static let operatorAlreadyPresent = "Un opérateur est déjà mis !"
		static let enterCorrectExpression = "Entrez une expression correcte !"
		static let startNewComputation = "Démarrez un nouveau calcul !"
		static let divisionByZero = "Vous ne pouvez pas diviser par zéro !"
	}

	enum ErrorActionTitle: String {
		case OK
	}
}
