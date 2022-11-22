//
//  MapViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import Foundation
import CoreLocation

class MapViewModel: ObservableObject {
	
	@Published var locations = [
		StudentLocation(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
		StudentLocation(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))]
}
