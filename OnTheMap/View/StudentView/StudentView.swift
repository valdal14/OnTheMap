//
//  StudentView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 25/11/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct StudentView: View {
	
	lazy var geocoder = CLGeocoder()
	
	//MARK: Binding variables
	@Environment(\.dismiss) var dismiss
	@StateObject private var studentVM = StudentViewModel()
	@State private var firstName = ""
	@State private var lastName = ""
	@State private var country = ""
	@State private var city = ""
	@State private var street = ""
	@State private var url = ""
	@State private var fullAddress = ""
	
	//MARK: - Validation States
	@State private var isValidFirstName = false
	@State private var isValidLastName = false
	@State private var isValidCountry = false
	@State private var isValidCity = false
	@State private var isValidStreet = false
	@State private var isValidUrl = false
	
	
	//MARK: - View
	
    var body: some View {
		VStack {
			if studentVM.wasCurrentUserAlreadyPosted {
				HStack{}
					.alert(studentVM.showOverrideLocationMessage, isPresented: Binding<Bool>(
						get: { studentVM.wasCurrentUserAlreadyPosted }, set: {_ in }
					)) {
						Button("Dismiss") {}
						Button("Override") {
							print("Override Location")
						}
					}
			} else {
				VStack {
					Form {
						Section {
							TextField("first name", text: $firstName)
								.onTheMapTextFieldModifier()
								.onChange(of: firstName) { firstName in
									isValidFirstName = String.validateCommonFields(firstName)
								}
							TextField("last name", text: $lastName)
								.onTheMapTextFieldModifier()
								.onChange(of: lastName) { lastName in
									isValidLastName = String.validateCommonFields(lastName)
								}
						} header: {
							Text("Personal Information")
						}
						Section {
							TextField("personal url", text: $url)
								.onTheMapTextFieldModifier()
								.onChange(of: url) { url in
									isValidUrl = String.validateURL(url)
								}
						} header: {
							Text("URL Information")
						}
						Section {
							TextField("country", text: $country)
								.onTheMapTextFieldModifier()
								.onChange(of: country) { country in
									isValidCountry = String.validateCommonFields(country)
								}
							TextField("city", text: $city)
								.onTheMapTextFieldModifier()
								.onChange(of: city) { city in
									isValidCountry = String.validateCommonFields(city)
								}
							TextField("street", text: $street)
								.onTheMapTextFieldModifier()
								.onChange(of: street) { street in
									isValidCountry = String.validateCommonFields(street)
								}
						} header: {
							Text("Location Information")
						}
					}
					
					ButtonLoginView(btnText: "Next", isValidForm: true) {
						print("Next Screen")
					}
				}
			}
		}
    }
}

struct StudentViewDark_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
			.preferredColorScheme(.dark)
    }
}

struct StudentViewLight_Previews: PreviewProvider {
	static var previews: some View {
		StudentView()
			.preferredColorScheme(.light)
	}
}
