//
//  MapViewModel.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import Foundation
import CoreLocation

@MainActor
public class MapViewModel: ObservableObject {
	
	private var studentInformation = [Student]()
	@Published private(set) var studentLocations: [StudentLocations] = []
	@Published private(set) var showStudentError = false
	@Published private(set) var locationRequestCompled = false
	
	func getStudentLocations() {
		Task {
			do {
				studentInformation = try await Network.shared.getStudentLocations()
				studentLocations = parseStudentLocationResponse(studentsInfo: studentInformation)
				showStudentError = false
			} catch let error as Network.NetworkError {
				print(error)
				showStudentError = true
			}
		}
	}
	
	//MARK: - Helper functions
	private func parseStudentLocationResponse(studentsInfo: [Student]) -> [StudentLocations] {
		var studentLocations: [StudentLocations] = []
		
		studentsInfo.forEach { student in
			studentLocations.append(StudentLocations(firstName: student.firstName,
													 lastName: student.firstName,
													 mapString: student.mapString,
													 mediaURL: student.mediaURL,
													 uniqueKey: student.uniqueKey,
													 coordinate: CLLocationCoordinate2D(latitude: student.latitude, longitude: student.longitude)))
		}
		
		locationRequestCompled = true
		return studentLocations
	}
}
