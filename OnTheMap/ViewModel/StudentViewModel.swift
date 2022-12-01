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
	
	@Published var showOverrideLocationMessage = "There is already a pin on the Map with the same location. Would you like to override? If so, click on the Next button"
	@Published var showPostError = false
	
	
	func postUserInformation(firstName: String, lastName: String, latitude: Double, longitude: Double, country: String, city: String, street: String, mediaURL: String) {
		Task {
			do {
				_ = try await Network.shared.postStudentLocation(firstName: firstName,
																 lastName: lastName,
																 latitude: latitude,
																 longitude: longitude,
																 mapString: "\(country), \(city), \(street)",
																 mediaURL: mediaURL)
				showPostError = false
			} catch let error as Network.NetworkError {
				print("POST Error: \(error.localizedDescription)")
				showPostError = true
			}
		}
	}
}

