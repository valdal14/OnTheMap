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
