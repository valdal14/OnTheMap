//
//  LoginHeader.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import SwiftUI

struct LoginHeader: View {
	var body: some View {
		VStack {
			Image("UdacityLogo")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: CGFloat(156), height: CGFloat(156), alignment: .center)
			Text("Login with Udacity")
				.fontWeight(.medium)
				.padding(.top, 20)
		}
		.padding(20)
	}
}

struct LoginHeader_Previews: PreviewProvider {
	static var previews: some View {
		LoginHeader()
	}
}
