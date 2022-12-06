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
	@StateObject var headerVM = HeaderViewModel()
	
    var body: some View {
		HStack(alignment: .top) {
			Button {
				headerVM.performLogout()
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
		.fullScreenCover(isPresented: Binding<Bool>(
			get: { headerVM.wasLoggedOut }, set: {_ in }
		), content: {
			LoginView()
		})
		.alert(headerVM.networkError, isPresented: Binding<Bool>(
			get: { headerVM.showLogoutError }, set: {_ in })
		) {
			Button("Please try again", role: .cancel) {
				headerVM.showLogoutError = false
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
