//
//  ListView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct ListView: View {
	
	@EnvironmentObject var mapVM : MapViewModel
	
	var body: some View {
		List(mapVM.studentLocations.sorted(by: { $0.createdAt > $1.createdAt })) { location in
			HStack {
				Image(systemName: "mappin")
					.fontWeight(.bold)
					.foregroundColor(Color("UdacityColor"))
				Link("\(location.firstName) \(location.lastName)", destination: URL(string: location.mediaURL)!)
			}
		}
	}
	
	struct ListViewDark_Previews: PreviewProvider {
		static var previews: some View {
			ListView()
			.preferredColorScheme(.dark)
		}
	}
	
	struct ListViewLight_Previews: PreviewProvider {
		static var previews: some View {
			ListView()
			.preferredColorScheme(.light)
		}
	}
}
