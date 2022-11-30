//
//  MapView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI
import MapKit

struct MapView: View {
	
	@Binding var locations : [StudentLocation]
	
	@State private var map = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7484445, longitude: -73.9878584), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
	
    var body: some View {
		Map(coordinateRegion: $map, annotationItems: locations) { location in
			MapMarker(coordinate: location.coordinate)
		}
    }
}

struct MapViewDark_Previews: PreviewProvider {
    static var previews: some View {
		MapView(locations: Binding<[StudentLocation]>(
			get: { MapViewModel().studentLocations }, set: { _ in }))
			.preferredColorScheme(.dark)
    }
}

struct MapViewLight_Previews: PreviewProvider {
	static var previews: some View {
		MapView(locations: Binding<[StudentLocation]>(
			get: { MapViewModel().studentLocations }, set: { _ in }))
			.preferredColorScheme(.light)
	}
}
