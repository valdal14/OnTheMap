//
//  ListView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct ListView: View {
	
	@Binding var locations : [StudentLocation]
	
    var body: some View {
		List(locations.filter({ student in
			!student.firstName.isEmpty && !student.lastName.isEmpty && validateMediaURL(urlString: student.mediaURL) != "invalid url"
		})) { location in
			HStack {
				Image(systemName: "mappin")
					.fontWeight(.bold)
					.foregroundColor(Color("UdacityColor"))
				Link("\(location.firstName) \(location.lastName)", destination: URL(string: location.mediaURL)!)
			}
		}
    }
	
	//MARK: - Helper function
	private func validateMediaURL(urlString: String) -> String {
		if let url = URL(string: urlString) {
			return url.absoluteString
		} else {
			return "invalid url"
		}
	}
}

struct ListViewDark_Previews: PreviewProvider {
    static var previews: some View {
        ListView(locations: Binding<[StudentLocation]>(
			get: { MapViewModel().studentLocations }, set: { _ in }))
			.preferredColorScheme(.dark)
    }
}

struct ListViewLight_Previews: PreviewProvider {
	static var previews: some View {
		ListView(locations: Binding<[StudentLocation]>(
			get: { MapViewModel().studentLocations }, set: { _ in }))
			.preferredColorScheme(.light)
	}
}
