//
//  ContentView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 19/11/22.
//

import SwiftUI

struct LoginView: View {
	@State private var email : String = "Email"
	@State private var pwd: String = "Password"

    var body: some View {
        VStack {
			VStack {
				Image("UdacityLogo")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: CGFloat(156), height: CGFloat(156), alignment: .center)
				Text("Login with Udacity")
					.fontWeight(.medium)
					.padding(.top, 20)
			}
			.padding(10)
			Form {
				TextField("Email", text: $email)
					.onTapGesture {
						email = ""
					}
				TextField("Password", text: $pwd)
					.onTapGesture {
						pwd = ""
					}
				Button("Login") {
					print("i was pressed")
				}
				.frame(maxWidth: .infinity, alignment: .center)
				.buttonStyle(.borderedProminent)
				.buttonBorderShape(.roundedRectangle)
				.tint(Color("UdacityColor"))
				.foregroundColor(.white)
				
				Link("Don't have an account? Sign Up", destination: URL(string: "https://auth.udacity.com/sign-in")!)
					.fontWeight(.light)
					.tint(Color("UdacityColor"))
					.frame(maxWidth: .infinity, alignment: .center)
			}
        }
    }
}

struct LoginViewDark_Previews: PreviewProvider {
    static var previews: some View {
		LoginView()
			.preferredColorScheme(.dark)
    }
}

struct LoginViewLight_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
			.preferredColorScheme(.light)
	}
}
