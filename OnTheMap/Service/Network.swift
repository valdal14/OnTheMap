//
//  Network.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import Foundation

class Network {
	
	static let shared: Network = Network()
	
	struct Authentication {
		static var accountKey = ""
		static var sessionId = ""
	}
	
	enum Endpoint {
		static let udacityBaseURL = "https://onthemap-api.udacity.com/v1/"
		
		case login
		case studentLocations
		
		var stringValue: String {
			switch self {
				case .login: return Endpoint.udacityBaseURL + "session"
				case .studentLocations: return Endpoint.udacityBaseURL + "StudentLocation?order=-updatedAt"
			}
		}
		
		var url: URL? { return URL(string: stringValue)!}
	}
	
	
	enum NetworkError: Error {
		case badURL
		case badRequest
		case decodingError
	}
	
	
	func login(username: String, password: String) async throws {
		
		guard let url = Endpoint.login.url else { throw NetworkError.badURL }
		
		var req = URLRequest(url: url)
		req.httpMethod = "POST"
		req.addValue("application/json", forHTTPHeaderField: "Accept")
		req.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let data = LoginRequest(udacity: Udacity(username: username, password: password))
		req.httpBody = try JSONEncoder().encode(data)
		
		let (resposeData, response) = try await URLSession.shared.data(for: req)
		
		let res = response as! HTTPURLResponse
		
		if res.statusCode != 200 {
			throw NetworkError.badRequest
		} else {
			
			// skip over the first 5 characters
			let range = (5..<resposeData.count)
			let newData = resposeData.subdata(in: range)
			// ------------------------------->
			
			let decodedData = try? JSONDecoder().decode(LoginResponse.self, from: newData)
			
			if let decodedData = decodedData {
				Authentication.accountKey = decodedData.account.key
				Authentication.sessionId = decodedData.session.id
			} else {
				throw NetworkError.decodingError
			}
		}
	}
	
	func getStudentLocations() async throws -> [Student] {
		guard let url = Endpoint.studentLocations.url else { throw NetworkError.badURL }
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		let res = response as! HTTPURLResponse
		
		if res.statusCode != 200 {
			throw NetworkError.badRequest
		} else {
			
			let decodedData = try? JSONDecoder().decode(StudentInfo.self, from: data)
			
			if let decodedData = decodedData {
				return decodedData.results
			} else {
				throw NetworkError.decodingError
			}
		}
	}
	
}
