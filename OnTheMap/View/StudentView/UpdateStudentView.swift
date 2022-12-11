//
//  UpdateStudentView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 10/12/22.
//

import SwiftUI
import CoreLocation

struct UpdateStudentView: View {
	
	//MARK: Binding variables
	@Environment(\.dismiss) var dismiss
	@StateObject private var studentVM = UpdateStudentViewModel()
	@EnvironmentObject var mapVM : MapViewModel
	@State private var address = ""
	@State private var mediaUrl = ""
	@State private var noLocationFound = false
	@State private var presentMap = false
	@State private var allowUpdate = false
	@State private var icon = ""
	
	//MARK: - Validation States
	@State private var isValidUrl = false
	@State private var isValidAddress = false
	@State private var isValidForm = false
	
	var body: some View {
		
		VStack {
			Text("Welcome \(mapVM.studentLocations.last!.firstName) \(mapVM.studentLocations.last!.lastName)")
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
			
			SearchButtonView(systemImageName: "magnifyingglass", isValidForm: (isValidAddress)) {
				hideKeyboard()
				updateNewLocation()
			}
			.alert("OnTheMap", isPresented: Binding<Bool>(
				get: { studentVM.wasUserLocationUpdated }, set: {_ in })) {
					Button("New Location updated!!!") {
						studentVM.wasUserLocationUpdated = false
						dismiss()
					}
				}
		}
		.alert("No location found", isPresented: $noLocationFound) {
			Button("Dismiss") {}
		}
		.padding()
		.alert("Error updating new location", isPresented: Binding<Bool>(
			get: { studentVM.showUpdateError }, set: { _ in })) {
				Button("Dismiss") {}
			}
		
	}
	
	//MARK: - Helper function
	private func validateForm() -> Bool {
		return isValidAddress && isValidUrl
	}
	
	private func updateNewLocation(){
		studentVM.showUpdateError = false
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
					let coordinate = location.coordinate
					
					let lastEntry = mapVM.studentLocations.removeLast()
					mapVM.studentLocations.append(StudentLocation(createdAt: Date().formatted(), firstName: lastEntry.firstName, lastName: lastEntry.lastName, mapString: address, mediaURL: mediaUrl, uniqueKey: lastEntry.uniqueKey, coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)))
					
					presentMap = true
					
					studentVM.updateStudentInformation(createdAt: Date().formatted(), uniqueKey: mapVM.studentLocations.last!.uniqueKey, firstName: mapVM.studentLocations.last!.firstName, lastName: mapVM.studentLocations.last!.lastName, latitude: coordinate.latitude, longitude: coordinate.longitude, address: address, mediaURL: mediaUrl)
					
				} else {
					noLocationFound = true
					presentMap = false
				}
			}
		}
	}
}

struct UpdateStudentViewDark_Previews: PreviewProvider {
	static var previews: some View {
		UpdateStudentView()
			.preferredColorScheme(.dark)
	}
}

struct UpdateStudentViewLight_Previews: PreviewProvider {
	static var previews: some View {
		UpdateStudentView()
			.preferredColorScheme(.light)
	}
}
