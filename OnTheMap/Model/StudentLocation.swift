//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import Foundation
import CoreLocation

struct StudentInfo: Codable {
	var results: [Student]
}

struct Student : Codable {
	let createdAt: String
	let firstName: String
	let lastName: String
	let latitude: Double
	let longitude: Double
	let mapString: String
	let mediaURL: String
	let uniqueKey: String
}

struct StudentLocation: Identifiable, Equatable {
	let id = UUID()
	let firstName: String
	let lastName: String
	let mapString: String
	let mediaURL: String
	let uniqueKey: String
	let coordinate: CLLocationCoordinate2D
	
	static func == (lhs: StudentLocation, rhs: StudentLocation) -> Bool {
		return lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.coordinate.longitude == rhs.coordinate.longitude
	}
}

struct StudentResponse: Codable {
	let createdAt: String
	let objectId: String
}

