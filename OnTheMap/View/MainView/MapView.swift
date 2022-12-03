//
//  MapView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI
import MapKit

struct MapView: View {
	
	@EnvironmentObject var mapVM : MapViewModel
	
	var body: some View {
		Map(coordinateRegion: Binding<MKCoordinateRegion>(
			get: { MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (mapVM.studentLocations.last?.coordinate.latitude)!, longitude: (mapVM.studentLocations.last?.coordinate.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)) }, set: {_ in }), annotationItems: mapVM.studentLocations) { loc in
				MapMarker(coordinate: CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude))
			}
		
//		Map(coordinateRegion: Binding<MKCoordinateRegion>(
//			get: { MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (mapVM.studentLocations.last?.coordinate.latitude)!, longitude: (mapVM.studentLocations.last?.coordinate.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)) }, set: {_ in }), annotationItems: mapVM.studentLocations) { loc in
//				MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)) {
//					StudentAnnotationView(firstName: loc.firstName, LastName: loc.lastName, url: loc.mediaURL)
//				}
//			}
		
	}
}

struct MapViewDark_Previews: PreviewProvider {
	static var previews: some View {
		MapView()
		.preferredColorScheme(.dark)
	}
}

struct MapViewLight_Previews: PreviewProvider {
	static var previews: some View {
		MapView()
		.preferredColorScheme(.light)
	}
}
