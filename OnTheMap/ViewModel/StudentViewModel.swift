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
	@Published var wasCurrentUserAlreadyPosted = false
	@Published var showPostError = false
	@Published var newStudent: [StudentLocation] = []
	
	
	func postUserInformation(country: String, city: String, street: String) {
		Task {
			do {
				wasCurrentUserAlreadyPosted = try await Network.shared.postStudentLocation(firstName: newStudent.last!.firstName,
																						   lastName: newStudent.last!.lastName,
																						   latitude: newStudent.last!.coordinate.latitude,
																						   longitude: newStudent.last!.coordinate.longitude,
																						   mapString: "\(country), \(city), \(street)",
																						   mediaURL: newStudent.last!.mediaURL)
				showPostError = false
			} catch let error as Network.NetworkError {
				print("POST Error: \(error.localizedDescription)")
				showPostError = true
			}
		}
	}
	
	func addNewStudentLocation(firstName: String, lastName: String, latitude: Double, longitude: Double, country: String, city: String, street: String, mediaURL: String) {
		newStudent.append(StudentLocation(firstName: firstName, lastName: lastName, mapString: "\(country), \(city), \(street)", mediaURL: mediaURL, uniqueKey: UUID().uuidString, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
	}
	
	func checkIfCurrentStudentAlreadyPostLocation(locations: [StudentLocation], latidute: Double, longitude: Double) -> Bool {
		locations.forEach { location in
			if location.coordinate.latitude == latidute && location.coordinate.longitude == longitude {
				wasCurrentUserAlreadyPosted = true
			}
		}
		
		return wasCurrentUserAlreadyPosted
	}
	
	func changeWasCurrentUserAlreadyPostedStatus() {
		wasCurrentUserAlreadyPosted.toggle()
	}

}

