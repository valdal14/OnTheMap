//
//  StudentViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 25/11/22.
//

import Foundation
import SwiftUI
import CoreLocation

@MainActor
class StudentViewModel: ObservableObject {
	
	@Published var showPostError = false
	@Published var wasNewUserPosted = false
	@Published var firstName = ""
	@Published var lastName = ""
	private(set) var networkError = ""
	
	func postNewStudentInformation(firstName: String, lastName: String, latitude: Double, longitude: Double, address: String, mediaURL: String) {
		Task {
			do {
				_ = try await Network.shared.postStudentLocation(firstName: firstName,
																 lastName: lastName,
																 latitude: latitude,
																 longitude: longitude,
																 mapString: address,
																 mediaURL: mediaURL)
				wasNewUserPosted = true
				showPostError = false
			} catch let error as Network.NetworkError {
				print("POST Error: \(error.localizedDescription)")
				networkError = error.localizedDescription
				showPostError = true
				wasNewUserPosted = false
			}
		}
	}
	
	func getRandomUserInformation() {
		Task {
			do {
				let studentInformation : StudentInformation = try await Network.shared.getRandomUserInfo()
				firstName = studentInformation.firstName
				lastName = studentInformation.lastName
			} catch let error as Network.NetworkError {
				(networkError, showPostError) = Network.shared.handleErrorResponse(error: error)
			}
		}
	}
}

