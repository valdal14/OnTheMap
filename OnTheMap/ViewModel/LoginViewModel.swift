//
//  LoginViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
	
	@Published var showLoginError = false
	@Published private(set) var presentMainView = false
	private(set) var networkError = ""
	
	func performUdacityLogin(username: String, password: String) {
		Task {
			do {
				try await Network.shared.login(username: username, password: password)
				showLoginError = false
				presentMainView = true
			} catch let error as Network.NetworkError {
				(networkError, showLoginError) = Network.shared.handleErrorResponse(error: error)
			}
		}
	}
}
