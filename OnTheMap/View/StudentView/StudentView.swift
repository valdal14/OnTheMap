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
	@State var studentLocation: [StudentLocation]
	
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
					
					if presentMap {
						
						Section("Selected Location") {
							VStack {
								CurrentMapView(locations: Binding<[StudentLocation]>(
									get: { studentLocation }, set: {_ in }
								), coordinate: Binding<CLLocationCoordinate2D>(
								get: { CLLocationCoordinate2D(latitude: (studentLocation.last?.coordinate.latitude)!, longitude: (studentLocation.last?.coordinate.longitude)!) }, set: {_ in }))
							}
						}
					}
					
				}
				
				HStack {
					
					SearchButtonView(systemImageName: "magnifyingglass", isValidForm: isValidForm) {
						presentMap = false
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
									
									// check if already have a pin on these coordinates
									let alreadyPostedLocation = studentVM.checkIfCurrentStudentAlreadyPostLocation(locations: studentLocation, latidute: coordinate.latitude, longitude: coordinate.longitude)
									
									
									studentLocation.append(StudentLocation(firstName: firstName, lastName: lastName, mapString: fullAddress, mediaURL: url, uniqueKey: UUID().uuidString, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)))
								
									if alreadyPostedLocation {
										overrideMap = true
									} else {
										presentMap = true
									}
									
								} else {
									print("No Matching Location Found")
									presentMap = false
									overrideMap = false
								}
							}
						}
					}
					
					Spacer()
					
					SearchButtonView(systemImageName: "plus.circle.fill", isValidForm: presentMap) {
						print("submit map")
					}
				}
				.padding()
			}
		}
		.alert(studentVM.showOverrideLocationMessage, isPresented: Binding<Bool>(
			get: { studentVM.wasCurrentUserAlreadyPosted }, set: {_ in }
		)) {
			Button("Dismiss") {
				studentVM.wasCurrentUserAlreadyPosted = false
				studentLocation.removeLast()
			}
			Button("Override") {
				print("Override Location")
				presentMap = true
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
		StudentView(studentLocation: MainView().mapVM.studentLocations)
			.preferredColorScheme(.dark)
	}
}

struct StudentViewLight_Previews: PreviewProvider {
	static var previews: some View {
		StudentView(studentLocation: MainView().mapVM.studentLocations)
			.preferredColorScheme(.light)
	}
}
