//
//  HeaderViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 6/12/22.
//

import Foundation

class HeaderViewModel: ObservableObject {
	
	@Published var wasLoggedOut = false
	@Published var showLogoutError = false
	private(set) var networkError = ""
	
	func performLogout() {
		Task {
			do {
				wasLoggedOut = try await Network.shared.logout()
			} catch let error as Network.NetworkError {
				(networkError, showLogoutError) = Network.shared.handleErrorResponse(error: error)
			}
		}
	}
}
