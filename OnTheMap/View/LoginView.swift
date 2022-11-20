//
//  ContentView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 19/11/22.
//

import SwiftUI

struct LoginView: View {
	@State private var email : String = ""
	@State private var pwd: String = ""
	@State private var isEmailValid: Bool = false
	@State private var isValidaPWD: Bool = false
	@ObservedObject private var loginVM: LoginViewModel = LoginViewModel()
	
	var body: some View {
		VStack {
			LoginHeader()
			
			TextField("Username", text: $email)
				.padding()
				.backgroundStyle(.gray)
				.cornerRadius(5.0)
				.padding(.bottom, 20)
				.onChange(of: email) { email in
					if loginVM.textFieldValidatorEmail(email) {
						isEmailValid = true
					} else {
						isEmailValid = false
					}
				}
			SecureField("Password", text: $pwd)
				.padding()
				.cornerRadius(5.0)
				.padding(.bottom, 20)
				.onChange(of: pwd) { password in
					if loginVM.textFieldValidatorPWD(password) {
						isValidaPWD = true
					} else {
						isValidaPWD = false
					}
				}
			
			ButtonLoginView(btnText: "Login", isValidForm: (isEmailValid && isValidaPWD)) {
				loginVM.performUdacityLogin(username: email, password: pwd)
			}
			
			Spacer()
			
			LinkView(textMessage: "Don't have an account? Sign Up", destinationURL: "https://auth.udacity.com/sign-in")
		}
		.padding()
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
