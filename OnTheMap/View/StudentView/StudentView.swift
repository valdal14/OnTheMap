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
	@State private var presentMap = false
	@State private var studentLocation: [StudentLocation] = []
	@State private var latitude: Double = 0.0
	@State private var longitude: Double = 0.0
	
	//MARK: - Validation States
	@State private var isValidFirstName = false
	@State private var isValidLastName = false
	@State private var isValidCountry = false
	@State private var isValidCity = false
	@State private var isValidStreet = false
	@State private var isValidUrl = false
	@State private var isValidForm = false
	
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
				NavigationStack {
					Form {
						Section {
							TextField("first name", text: $firstName)
								.onTheMapTextFieldModifier()
								.onChange(of: firstName) { firstName in
									isValidFirstName = String.validateCommonFields(firstName)
									isValidForm = validateForm()
								}
							TextField("last name", text: $lastName)
								.onTheMapTextFieldModifier()
								.onChange(of: lastName) { lastName in
									isValidLastName = String.validateCommonFields(lastName)
									isValidForm = validateForm()
								}
						} header: {
							Text("Personal Information")
						}
						Section {
							TextField("personal url", text: $url)
								.onTheMapTextFieldModifier()
								.onChange(of: url) { url in
									isValidUrl = String.validateURL(url)
									isValidForm = validateForm()
								}
						} header: {
							Text("URL Information")
						}
						Section {
							TextField("country", text: $country)
								.onTheMapTextFieldModifier()
								.onChange(of: country) { country in
									isValidCountry = String.validateCommonFields(country)
									isValidForm = validateForm()
								}
							TextField("city", text: $city)
								.onTheMapTextFieldModifier()
								.onChange(of: city) { city in
									isValidCity = String.validateCommonFields(city)
									isValidForm = validateForm()
								}
							TextField("street", text: $street)
								.onTheMapTextFieldModifier()
								.onChange(of: street) { street in
									isValidStreet = String.validateCommonFields(street)
									isValidForm = validateForm()
								}
						} header: {
							Text("Location Information")
						}
					}
					
					ButtonLoginView(btnText: "Next", isValidForm: isValidForm) {
						fullAddress = "\(country), \(city), \(street)"
						let geocoder = CLGeocoder()
						geocoder.geocodeAddressString(fullAddress) {placemarks, error in
							if let error = error {
								print(error)
							} else {
								var location: CLLocation?
								
								if let placemarks = placemarks, placemarks.count > 0 {
									location = placemarks.first?.location
								}
								
								if let location = location {
									let coordinate = location.coordinate
									latitude = coordinate.latitude
									longitude = coordinate.longitude
									
									studentVM.addNewStudentLocation(firstName: firstName, lastName: lastName, latitude: coordinate.latitude, longitude: coordinate.longitude, country: country, city: city, street: street, mediaURL: url)
									
									presentMap = true
									
								} else {
									print("No Matching Location Found")
									presentMap = false
								}
							}
						}
					}
					.sheet(isPresented: $presentMap) {
						CurrentMapView(locations: Binding<[StudentLocation]>(
							get: { studentVM.newStudent }, set: {_ in }
						))
					}
				}
			}
		}
	}
	
	//MARK: - Helper function
	private func validateForm() -> Bool {
		return isValidFirstName && isValidLastName && isValidCity && isValidCity && isValidStreet && isValidUrl
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
