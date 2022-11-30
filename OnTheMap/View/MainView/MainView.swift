//
//  MainView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct MainView: View {
	
	@StateObject var mapVM = MapViewModel()
	@State private var loading = true
	
	var body: some View {
		VStack {
			HeaderView(studentLocation: Binding<[StudentLocation]>(
				get: { mapVM.studentLocations }, set: {_ in }))
			
			NavigationStack {
				if mapVM.locationRequestCompled {
					TabView {
						MapView(locations: Binding<[StudentLocation]>(
							get: { mapVM.studentLocations }, set: {_ in }))
							.tabItem {
								Label("Map", systemImage: "mappin.square.fill")
							}
						
						ListView(locations: Binding<[StudentLocation]>(
							get: { mapVM.studentLocations }, set: {_ in }))
							.tabItem {
								Label("Map", systemImage: "list.bullet.rectangle.fill")
							}
					}
				} else {
					ProgressView()
				}
			}
		}
		.onAppear { mapVM.getStudentLocations() }
	}
}

struct MainViewDark_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.preferredColorScheme(.dark)
	}
}

struct MainViewLight_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.preferredColorScheme(.light)
	}
}
