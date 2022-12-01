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
	@Binding var coordinate: CLLocationCoordinate2D
	
    var body: some View {
		Map(coordinateRegion: Binding<MKCoordinateRegion>(
			get: { MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)) }, set: {_ in }), annotationItems: locations) { loc in
				MapMarker(coordinate: coordinate)
		}
    }
}

struct MapViewDark_Previews: PreviewProvider {
    static var previews: some View {
		MapView(locations: Binding<[StudentLocation]>(
			get: { MapViewModel().studentLocations }, set: { _ in }), coordinate: Binding<CLLocationCoordinate2D>(
				get: { CLLocationCoordinate2D(latitude: 40.7484445, longitude: -73.9878584) }, set: {_ in }))
			.preferredColorScheme(.dark)
    }
}

struct MapViewLight_Previews: PreviewProvider {
	static var previews: some View {
		MapView(locations: Binding<[StudentLocation]>(
			get: { MapViewModel().studentLocations }, set: { _ in }), coordinate: Binding<CLLocationCoordinate2D>(
				get: { CLLocationCoordinate2D(latitude: 40.7484445, longitude: -73.9878584) }, set: {_ in }))
			.preferredColorScheme(.light)
	}
}
