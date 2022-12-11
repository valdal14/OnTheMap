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
	@State private var address = ""
	@State private var mediaUrl = ""
	@State private var presentMap = false
	@State private var noLocationFound = false
	@EnvironmentObject var mapVM : MapViewModel
	
	//MARK: - Validation States
	@State private var isValidUrl = false
	@State private var isValidAddress = false
	@State private var isValidForm = false
	
	//MARK: - View
	
	var body: some View {
		
		HStack{
			VStack {
				VStack {
					Text("Welcome \(studentVM.firstName) \(studentVM.lastName)")
						.padding()
					Text("Fill the form to search a new location")
					Text("URL and Address are mandatory")
						.fontWeight(.ultraLight)
				}
				Form {
					Section {
						TextField("personal url", text: $mediaUrl)
							.onTheMapTextFieldModifier()
							.onChange(of: mediaUrl) { url in
								isValidUrl = String.validateURL(url)
								isValidForm = validateForm()
							}
					} header: {
						Text("URL")
					}
					Section {
						TextField("full address", text: $address)
							.onTheMapTextFieldModifier()
							.onChange(of: address) { address in
								isValidAddress = String.validateCommonFields(address)
								isValidForm = validateForm()
							}
					} header: {
						Text("Address")
					}
					if presentMap {
						
						Section("Selected Location") {
							VStack {
								CurrentMapView()
							}
						}
					}
				}
				
				HStack {
					
					SearchButtonView(systemImageName: "magnifyingglass", isValidForm: (isValidAddress && isValidUrl)) {
						hideKeyboard()
						storeNewLocation()
					}
					
					Spacer()
					
					SearchButtonView(systemImageName: "plus.circle.fill", isValidForm: (presentMap && isValidAddress && isValidUrl)) {
						Task {
							studentVM.postNewStudentInformation(firstName: mapVM.studentLocations.last!.firstName, lastName: mapVM.studentLocations.last!.lastName, latitude: (mapVM.studentLocations.last?.coordinate.latitude)!, longitude: (mapVM.studentLocations.last?.coordinate.longitude)!, address: address, mediaURL: mediaUrl)
						}
					}
					.alert("OnTheMap", isPresented: Binding<Bool>(
						get: { studentVM.wasNewUserPosted }, set: {_ in })) {
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
			.onAppear { studentVM.getRandomUserInformation() }
			.alert("No location found", isPresented: $noLocationFound) {
				Button("Dismiss") {}
			}
		}
	}
	
	//MARK: - Helper function
	private func validateForm() -> Bool {
		return isValidAddress && isValidUrl
	}
	
	private func storeNewLocation(){
		studentVM.showPostError = false
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(address) { placemarks, error in
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
					
					mapVM.studentLocations.append(StudentLocation(createdAt: Date().formatted(), firstName: studentVM.firstName, lastName: studentVM.lastName, mapString: address, mediaURL: mediaUrl, uniqueKey: UUID().uuidString, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)))
					
					presentMap = true
					
				} else {
					noLocationFound = true
					presentMap = false
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
