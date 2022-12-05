//
//  MapViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import Foundation
import CoreLocation
import Combine

@MainActor
public class MapViewModel: ObservableObject {
	
	private var studentInformation = [Student]()
	@Published var studentLocations: [StudentLocation] = []
	@Published var showStudentError = false
	@Published private(set) var locationRequestCompled = false
	var networkError = ""
	
	func getStudentLocations() {
		Task {
			do {
				let _ = try await Network.shared.getStudentLocation()
					.publisher
					.filter({ student in
						!student.firstName.isEmpty && !student.lastName.isEmpty && validateMediaURL(urlString: student.mediaURL) != "invalid url"
					})
					.removeDuplicates(by: { $0.latitude == $1.latitude && $0.longitude == $0.longitude })
					.sink(receiveValue: { student in
						self.studentInformation.append(student)
					})
				
				studentLocations = parseStudentLocationResponse(studentsInfo: studentInformation)
				showStudentError = false
			} catch let error as Network.NetworkError {
				(networkError, showStudentError) = Network.shared.handleErrorResponse(error: error)
			}
		}
	}
	
	//MARK: - Helper functions
	private func parseStudentLocationResponse(studentsInfo: [Student]) -> [StudentLocation] {
		var studentLocations: [StudentLocation] = []
		
		studentsInfo.forEach { student in
			studentLocations.append(StudentLocation(createdAt: Date().formatted(),
													 firstName: student.firstName,
													 lastName: student.firstName,
													 mapString: student.mapString,
													 mediaURL: student.mediaURL,
													 uniqueKey: student.uniqueKey,
													 coordinate: CLLocationCoordinate2D(latitude: student.latitude, longitude: student.longitude)))
		}
		
		locationRequestCompled = true
		return studentLocations
	}
	
	private func validateMediaURL(urlString: String) -> String {
		if let url = URL(string: urlString) {
			return url.absoluteString
		} else {
			return "invalid url"
		}
	}
}
