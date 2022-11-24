//
//  MapView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI
import MapKit

struct MapView: View {
	
	@StateObject private var mapVM = MapViewModel()
	
	@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.7303688, longitude: -86.5861037), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
	
    var body: some View {
		Map(coordinateRegion: $mapRegion, annotationItems: mapVM.studentLocations) { location in
			MapMarker(coordinate: location.coordinate)
		}
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
