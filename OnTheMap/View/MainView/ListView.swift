//
//  ListView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct ListView: View {
	
	@EnvironmentObject var mapVM : MapViewModel
	@StateObject var loginVM = LoginViewModel()
	
	var body: some View {
		List(mapVM.studentLocations.sorted(by: { $0.createdAt > $1.createdAt })) { location in
			HStack {
				Image(systemName: "mappin")
					.fontWeight(.bold)
					.foregroundColor(Color("UdacityColor"))
				if loginVM.isInternetAvailable {
					Link("\(location.firstName) \(location.lastName)", destination: URL(string: location.mediaURL)!)
				} else {
					Text("\(location.firstName) \(location.lastName)")
					Spacer()
					Image(systemName: loginVM.wifiImageName)
						.foregroundColor(.red)
						.frame(width: 50, height: 50, alignment: .center)
				}
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
