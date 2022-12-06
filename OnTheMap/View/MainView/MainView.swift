//
//  MainView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI
import MapKit

struct MainView: View {
	
	@State private var loading = true
	@State private var backToLogin = false
	@EnvironmentObject var mapVM : MapViewModel
	
	var body: some View {
		VStack {
			HeaderView()
			Spacer()
			VStack {
				if mapVM.locationRequestCompled {
					TabView {
						MapView()
							.tabItem {
								Label("Map", systemImage: "mappin.square.fill")
							}
						
						ListView()
							.tabItem {
								Label("Map", systemImage: "list.bullet.rectangle.fill")
							}
					}
				} else {
					ProgressView()
				}
			}
			.alert(mapVM.networkError, isPresented: Binding<Bool>(
				get: { mapVM.showStudentError }, set: {_ in })
			) {
				Button("Please try again", role: .cancel) {
					mapVM.showStudentError = false
					backToLogin = true
				}
			}
		}
		.fullScreenCover(isPresented: $backToLogin) {
			LoginView()
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
