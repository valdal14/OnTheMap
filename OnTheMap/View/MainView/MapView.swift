//
//  MapView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        Text("MapView")
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
