//
//  CurrentMapView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 28/11/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct CurrentMapView: View {
	@Environment(\.dismiss) var dismiss
	@State private var map = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.9139935, longitude: 12.4531818), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
	@Binding var locations: [StudentLocation]
	
	var body: some View {
		ZStack {
			Map(coordinateRegion: $map, annotationItems: locations) { currentLocation in
				MapMarker(coordinate: currentLocation.coordinate)
			}
			.frame(height: 300, alignment: .center)
		}
	}
}

struct CurrentMapViewDark_Previews: PreviewProvider {
    static var previews: some View {
		CurrentMapView(locations: Binding<[StudentLocation]>(
			get: { [StudentLocation(firstName: "Valerio", lastName: "DAlessio", mapString: "Via Premuda 7", mediaURL: "http://icloud.com", uniqueKey: UUID().uuidString, coordinate: CLLocationCoordinate2D(latitude: 41.9139935, longitude: 12.4531818))] }, set: { _ in }))
			.preferredColorScheme(.dark)
    }
}
