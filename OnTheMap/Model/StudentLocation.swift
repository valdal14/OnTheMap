//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import Foundation
import CoreLocation

struct StudentLocation: Identifiable {
	let id = UUID()
	let name: String
	let coordinate: CLLocationCoordinate2D
}

struct StudentInfo: Codable {
	let results: [Student]
}

struct Student : Codable {
	let firstName: String
	let lastName: String
	let latitude: Double
	let longitude: Double
	let mapString: String
	let mediaURL: String
	let uniqueKey: String
}

struct StudentLocations: Identifiable {
	let id = UUID()
	let firstName: String
	let lastName: String
	let mapString: String
	let mediaURL: String
	let uniqueKey: String
	let coordinate: CLLocationCoordinate2D
}
