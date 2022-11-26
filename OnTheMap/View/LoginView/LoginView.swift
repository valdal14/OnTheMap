//
//  ContentView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 19/11/22.
//

import SwiftUI

struct LoginView: View {
	@State private var email = ""
	@State private var pwd = ""
	@State private var isEmailValid = false
	@State private var isValidaPWD = false
	@StateObject var loginVM  = LoginViewModel()
	
	var body: some View {
		VStack {
			LoginHeader()
			
			TextField("Username", text: $email)
				.onTheMapTextFieldModifier()
				.onChange(of: email) { email in
					isEmailValid = String.validateEmail(email)
				}
			SecureField("Password", text: $pwd)
				.onTheMapTextFieldModifier()
				.onChange(of: pwd) { password in
					isValidaPWD = String.validatePassword(password)
				}
			
			ButtonLoginView(btnText: "Login", isValidForm: (isEmailValid && isValidaPWD)) {
				loginVM.performUdacityLogin(username: email, password: pwd)
			}
			.fullScreenCover(isPresented: Binding<Bool>(
				get: { loginVM.presentMainView }, set: {_ in }
			), content: {
				MainView()
			})
			.alert("Login Failed", isPresented: Binding<Bool>(
				get: { loginVM.showLoginError }, set: {_ in })
			) {
				Button("Please try again", role: .cancel) {
					loginVM.showLoginError = false
				}
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
