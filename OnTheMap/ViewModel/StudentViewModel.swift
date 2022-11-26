//
//  StudentViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 25/11/22.
//

import Foundation

@MainActor
class StudentViewModel: ObservableObject {
	
	let showOverrideLocationMessage = "You have already posted a student location. Woudl you like to override your current location?"
	@Published var wasCurrentUserAlreadyPosted = false
	@Published var showPostError = false
	
	func postUserInformation(firstName: String, lastName: String, latitude: Double, longitude: Double, mapString: String, mediaURL: String){
		Task {
			do {
				wasCurrentUserAlreadyPosted = try await Network.shared.postStudentLocation(firstName: firstName,
																						   lastName: lastName,
																						   latitude: latitude,
																						   longitude: longitude,
																						   mapString: mapString,
																						   mediaURL: mediaURL)
				showPostError = false
			} catch let error as Network.NetworkError {
				print("POST Error: \(error.localizedDescription)")
				showPostError = true
			}
		}
	}
}
