//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 6/12/22.
//

import Foundation

struct StudentInformation: Codable {
	let firstName: String
	let lastName: String
	
	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
	}
}
