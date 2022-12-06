//
//  Logout.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 6/12/22.
//

import Foundation

struct LogoutRequest: Codable {
	let session: LogoutSession
}

struct LogoutSession: Codable {
	let id: String
	let expiration: String
}
