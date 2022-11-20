//
//  LoginViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import Foundation

class LoginViewModel: ObservableObject {
	
	func textFieldValidatorEmail(_ email: String) -> Bool {
		if email.count > 100 {
			return false
		}
		let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
		return emailPredicate.evaluate(with: email)
	}
	
	func textFieldValidatorPWD(_ pwd: String) -> Bool {
		return pwd.count >= 6
	}
	
	func performUdacityLogin(username: String, password: String) {
		Task {
			try await Network.shared.login(username: username, password: password)
		}
	}
}
