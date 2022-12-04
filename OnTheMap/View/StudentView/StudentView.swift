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
	@State private var overrideMap = false
	@State private var noLocationFound = false
	@EnvironmentObject var mapVM : MapViewModel
	
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
		
		HStack{
			VStack {
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
					
					if presentMap && isValidForm {
						
						Section("Selected Location") {
							VStack {
								CurrentMapView()
							}
						}
					}
					
				}
				
				HStack {
					
					SearchButtonView(systemImageName: "magnifyingglass", isValidForm: isValidForm) {
						hideKeyboard()
						storeNewLocation(override: State<Bool>(initialValue: overrideMap))
					}
					
					Spacer()
					
					SearchButtonView(systemImageName: "plus.circle.fill", isValidForm: (presentMap && isValidForm)) {
						Task {
							studentVM.postUserInformation(firstName: mapVM.studentLocations.last!.firstName, lastName: mapVM.studentLocations.last!.lastName, latitude: (mapVM.studentLocations.last?.coordinate.latitude)!, longitude: (mapVM.studentLocations.last?.coordinate.longitude)!, country: country, city: city, street: street, mediaURL: url)
						}
					}
					.alert("OnTheMap", isPresented: Binding<Bool>(
						get: { studentVM.wasNewUserPosted }, set: { _ in })) {
						Button("New Location added!!!") {
							dismiss()
						}
					}
				}
				.padding()
				.alert("Error posting new location", isPresented: Binding<Bool>(
				get: { studentVM.showPostError }, set: { _ in })) {
					Button("Dismiss") {}
				}
			}
			.alert("No location found", isPresented: $noLocationFound) {
				Button("Dismiss") {}
			}
		}
		.alert(studentVM.showOverrideLocationMessage, isPresented: $overrideMap) {
			Button("Dismiss") {
				overrideMap = false
				mapVM.studentLocations.removeLast()
			}
			Button("Override") {
				print("Override Location")
				storeNewLocation(override: State<Bool>(initialValue: overrideMap))
				presentMap = true
				
			}
		}
	}
	
	//MARK: - Helper function
	private func validateForm() -> Bool {
		return isValidFirstName && isValidLastName && isValidCity && isValidCity && isValidStreet && isValidUrl
	}
	
	private func storeNewLocation(override: State<Bool>){
		presentMap = false
		fullAddress = "\(country), \(city), \(street)"
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(fullAddress) {placemarks, error in
			if let _ = error {
				noLocationFound = true
			} else {
				var location: CLLocation?
				
				if let placemarks = placemarks, placemarks.count > 0 {
					location = placemarks.first?.location
				}
				
				if let location = location {
					noLocationFound = false
					let coordinate = location.coordinate
					
					// check if the user wants to override the last location
					if override.wrappedValue {
						mapVM.studentLocations.append(StudentLocation(firstName: firstName, lastName: lastName, mapString: fullAddress, mediaURL: url, uniqueKey: UUID().uuidString, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)))

						presentMap = true
						
					} else {
						
						let alreadyPostedLocation = mapVM.studentLocations.filter { loc in
							loc.coordinate.latitude == coordinate.latitude && loc.coordinate.longitude == coordinate.longitude
						}
					
						if !alreadyPostedLocation.isEmpty {
							overrideMap = true
						} else {
							mapVM.studentLocations.append(StudentLocation(firstName: firstName, lastName: lastName, mapString: fullAddress, mediaURL: url, uniqueKey: UUID().uuidString, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)))
							
							presentMap = true
						}
					}
					
				} else {
					noLocationFound = true
					presentMap = false
					overrideMap = false
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
