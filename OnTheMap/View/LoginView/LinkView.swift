//
//  LinkView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import SwiftUI

struct LinkView: View {
	let textMessage : String
	let destinationURL : String
	@StateObject var loginVM = LoginViewModel()
	
    var body: some View {
		VStack {
			if loginVM.isInternetAvailable {
				Image(systemName: loginVM.wifiImageName)
					.foregroundColor(Color("UdacityColor"))
					.frame(width: 50, height: 50, alignment: .center)
				Text(loginVM.wifiNetworkDescription)
					.fontWeight(.ultraLight)
					.padding(.bottom, 2)
				Link(textMessage, destination: URL(string: destinationURL)!)
					.fontWeight(.light)
					.tint(Color("UdacityColor"))
					.frame(maxWidth: .infinity, alignment: .center)
			} else {
				Image(systemName: loginVM.wifiImageName)
					.foregroundColor(.red)
					.frame(width: 50, height: 50, alignment: .center)
				Text(loginVM.wifiNetworkDescription)
					.fontWeight(.ultraLight)
					.padding(.bottom, 2)
			}
		}
		
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
		LinkView(textMessage: "Don't have an account? Sign Up", destinationURL: "https://auth.udacity.com/sign-in")
    }
}
