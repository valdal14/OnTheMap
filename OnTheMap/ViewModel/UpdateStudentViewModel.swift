//
//  UpdateStudentViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 10/12/22.
//

import Foundation
import CoreLocation

@MainActor
class UpdateStudentViewModel : ObservableObject {
	
	@Published var showUpdateError = false
	@Published var wasUserLocationUpdated = false
	var networkError = ""
	
	func updateStudentInformation(createdAt: String, uniqueKey: String, firstName: String, lastName: String, latitude: Double, longitude: Double, address: String, mediaURL: String) {
		Task {
			do {
				_ = try await Network.shared.updateUser(createdAt: createdAt,
														firstName: firstName,
														lastName: lastName,
														latitude: latitude,
														longitude: longitude,
														mapString: address,
														mediaURL: mediaURL,
														uniqueKey: uniqueKey)
				wasUserLocationUpdated = true
			} catch let error as Network.NetworkError {
				wasUserLocationUpdated = false
				(networkError, showUpdateError) = Network.shared.handleErrorResponse(error: error)
			}
		}
	}
}
