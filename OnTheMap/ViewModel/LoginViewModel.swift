//
//  LoginViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import Foundation
import Network

@MainActor
class LoginViewModel: ObservableObject {
	
	let monitor = NWPathMonitor()
	let queue = DispatchQueue(label: "NetworkManager")
	@Published var isInternetAvailable = true
	@Published var showLoginError = false
	@Published private(set) var presentMainView = false
	private(set) var networkError = ""
	
	var wifiImageName: String {
		return isInternetAvailable ? "wifi" : "wifi.slash"
	}
	
	var wifiNetworkDescription: String {
		return isInternetAvailable ? "Connected to the Internet" : "No Internet Connection Available"
	}
	
	init(){
		monitor.pathUpdateHandler = { path in
			self.isInternetAvailable = path.status == .satisfied
		}
		
		monitor.start(queue: queue)
	}
	
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
