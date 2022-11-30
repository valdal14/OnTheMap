//
//  SearchButtonView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 30/11/22.
//

import SwiftUI

struct SearchButtonView: View {
	let systemImageName: String
	let isValidForm: Bool
	let completion: () -> Void
	
    var body: some View {
		Button {
			completion()
		} label: {
			Image(systemName: systemImageName)
				.font(.title)
				.foregroundColor(isValidForm ? Color("UdacityColor") : .gray)
		}
		.disabled(isValidForm == false)
		.padding()

    }
}

struct SearchButtonViewDark_Previews: PreviewProvider {
    static var previews: some View {
		SearchButtonView(systemImageName: "magnifyingglass", isValidForm: false, completion: { })
			.preferredColorScheme(.dark)
    }
}

struct SearchButtonViewLight_Previews: PreviewProvider {
	static var previews: some View {
		SearchButtonView(systemImageName: "magnifyingglass", isValidForm: false, completion: { })
			.preferredColorScheme(.light)
	}
}
