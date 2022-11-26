//
//  HeaderView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct HeaderView: View {
	
	@State private var showingStudentView = false
	
    var body: some View {
		HStack {
			Button {
				showingStudentView.toggle()
			} label: {
				Label("", systemImage: "mappin")
			}.sheet(isPresented: $showingStudentView) {
				StudentView()
			}

			Spacer()
			
			Text("On The Map")
				.fontWeight(.bold)
			
			Spacer()
			
			Button {
				print("I was pressed")
			} label: {
				Label("", systemImage: "goforward")
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
