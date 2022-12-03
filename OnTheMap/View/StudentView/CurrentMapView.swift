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
	@EnvironmentObject var mapVM : MapViewModel
	
	var body: some View {
		ZStack {
			Map(coordinateRegion: Binding<MKCoordinateRegion>(
				get: { MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (mapVM.studentLocations.last?.coordinate.latitude)!, longitude: (mapVM.studentLocations.last?.coordinate.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)) }, set: {_ in }), annotationItems: mapVM.studentLocations) { loc in
					MapMarker(coordinate: CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude))
				}
				.frame(height: 300, alignment: .center)
		}
	}
}

struct CurrentMapViewDark_Previews: PreviewProvider {
	static var previews: some View {
		CurrentMapView()
		.preferredColorScheme(.dark)
	}
}
