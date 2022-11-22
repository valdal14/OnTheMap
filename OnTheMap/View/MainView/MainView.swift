//
//  MainView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
		NavigationStack {
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
		}
		.navigationTitle("OnTheMap")
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
