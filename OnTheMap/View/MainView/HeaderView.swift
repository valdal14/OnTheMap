//
//  HeaderView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct HeaderView: View {
	
	@State private var showingStudentView = false
	@EnvironmentObject var mapVM : MapViewModel
	
    var body: some View {
		HStack(alignment: .top) {
			Button {
				mapVM.getStudentLocations()
			} label: {
				Label("", systemImage: "lock.slash.fill")
			}
			
			Spacer()
			
			Text("On The Map")
				.fontWeight(.bold)
			
			Spacer()
			
			Button {
				showingStudentView.toggle()
			} label: {
				Label("", systemImage: "mappin")
			}
			.sheet(isPresented: $showingStudentView) {
				StudentView()
			}
		}
		.padding()
    }
}

struct HeaderViewDark_Previews: PreviewProvider {
    static var previews: some View {
		HeaderView()
			.preferredColorScheme(.dark)
    }
}

struct HeaderViewLight_Previews: PreviewProvider {
	static var previews: some View {
		HeaderView()
			.preferredColorScheme(.light)
	}
}
