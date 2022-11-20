//
//  Login.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import Foundation

struct LoginRequest: Codable {
	let udacity : Udacity
}

struct Udacity: Codable {
	let username: String
	let password: String
}

struct LoginResponse: Codable {
	let account: Account
	let Session: Session
}

struct Account: Codable {
	let registered: Bool
	let key: String
}

struct Session: Codable {
	let id: String
	let expiration: String
}
