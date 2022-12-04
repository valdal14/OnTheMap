//
//  OnTheMap+Extension.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 26/11/22.
//

import Foundation
import UIKit
import SwiftUI

extension String {
	
	static func validateURL(_ urlString: String) -> Bool {
		let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
		let test = NSPredicate(format:"SELF MATCHES %@", regex)
		let result = test.evaluate(with: urlString)
		return result
	}
	
	static func validateEmail(_ email: String) -> Bool {
		if email.count > 100 {
			return false
		}
		let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
		let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
		return emailPredicate.evaluate(with: email)
	}
	
	static func validatePassword(_ pwd: String) -> Bool { return pwd.count >= 6 }
	
	static func validateCommonFields(_ text: String) -> Bool { return text.count >= 3 }
	
	static func validateFullAddress(country: String, street: String, city: String) -> Bool {
		return country.count >= 3 && street.count >= 3 && city.count >= 3
	}
}

#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif
