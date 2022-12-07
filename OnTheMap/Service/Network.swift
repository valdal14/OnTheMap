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
		case studentLocation
		case addLocation
		case updateLocation
		case getRandomUser
		
		var stringValue: String {
			switch self {
				case .login: return Endpoint.udacityBaseURL + "session"
				case .studentLocation: return Endpoint.udacityBaseURL + "StudentLocation?order=-updatedAt&limit=100"
				case .addLocation: return Endpoint.udacityBaseURL + "StudentLocation"
				case .updateLocation: return Endpoint.udacityBaseURL + "StudentLocation" + Authentication.sessionId
				case .getRandomUser: return Endpoint.udacityBaseURL + "users/3903878747"
			}
		}
		
		var url: URL? { return URL(string: stringValue)!}
	}
	
	
	enum NetworkError: Error {
		case badURL
		case badRequest
		case decodingError
		case notFound
		case serverError
		case wrongCredentials
	}
	
	private init(){}
	
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
		
		switch res.statusCode {
		case 200:
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
		case 404:
			throw NetworkError.notFound
		case 500:
			throw NetworkError.serverError
		default:
			throw NetworkError.wrongCredentials
		}
	}
	
	func logout() async throws -> Bool {
		guard let url = Endpoint.login.url else { throw NetworkError.badURL }
		
		var req = URLRequest(url: url)
		req.httpMethod = "DELETE"
		var xsrfCookie: HTTPCookie? = nil
		let sharedCookieStorage = HTTPCookieStorage.shared
		
		for cookie in sharedCookieStorage.cookies! {
		  if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
		}
		
		if let xsrfCookie = xsrfCookie {
			req.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
		}
		
		let (resposeData, response) = try await URLSession.shared.data(for: req)
		
		let res = response as! HTTPURLResponse
		
		switch res.statusCode {
		case 200:
			// skip over the first 5 characters
			let range = (5..<resposeData.count)
			let newData = resposeData.subdata(in: range)
			// ------------------------------->
			
			let decodedData = try? JSONDecoder().decode(LogoutRequest.self, from: newData)
			
			if let _ = decodedData {
				return true
			} else {
				throw NetworkError.decodingError
			}
		case 404:
			throw NetworkError.notFound
		case 500:
			throw NetworkError.serverError
		default:
			throw NetworkError.wrongCredentials
		}
	}
	
	func getRandomUserInfo() async throws -> StudentInformation {
		guard let url = Endpoint.getRandomUser.url else { throw NetworkError.badURL }
		
		let (resposeData, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		let res = response as! HTTPURLResponse
		
		switch res.statusCode {
		case 200:
			// skip over the first 5 characters
			let range = (5..<resposeData.count)
			let newData = resposeData.subdata(in: range)
			// ------------------------------->
			
			let decodedData = try? JSONDecoder().decode(StudentInformation.self, from: newData)
			
			if let decodedData = decodedData {
				return decodedData
			} else {
				throw NetworkError.decodingError
			}
		case 404:
			throw NetworkError.notFound
		case 500:
			throw NetworkError.serverError
		default:
			throw NetworkError.wrongCredentials
		}
	}
	
	func getStudentLocation() async throws -> [Student] {
		guard let url = Endpoint.studentLocation.url else { throw NetworkError.badURL }
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		let res = response as! HTTPURLResponse
		
		switch res.statusCode {
		case 200:
			let decodedData = try? JSONDecoder().decode(StudentInfo.self, from: data)
			
			if var decodedData = decodedData {
				decodedData.results.sort { s1, s2 in
					s1.createdAt > s2.createdAt
				}
				return decodedData.results
			} else {
				throw NetworkError.decodingError
			}
		case 404:
			throw NetworkError.notFound
		case 500:
			throw NetworkError.serverError
		default:
			throw NetworkError.wrongCredentials
		}
	}
	
	func postStudentLocation(firstName: String, lastName: String, latitude: Double, longitude: Double, mapString: String, mediaURL: String) async throws -> Bool {
		guard let url = Endpoint.addLocation.url else { throw NetworkError.badURL }
		
		let studentToPost = Student(createdAt: Date().formatted(), firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, mapString: mapString, mediaURL: mediaURL, uniqueKey: UUID().uuidString)
		
		var req = URLRequest(url: url)
		req.httpMethod = "POST"
		req.addValue("application/json", forHTTPHeaderField: "Content-Type")
		req.httpBody = try JSONEncoder().encode(studentToPost)
		
		let (data, response) = try await URLSession.shared.data(for: req)
		let res = response as! HTTPURLResponse
		
		switch res.statusCode {
		case 200:
			let decodedData = try? JSONDecoder().decode(StudentResponse.self, from: data)
			
			if let _ = decodedData {
				return true
			} else {
				throw NetworkError.decodingError
			}
		case 404:
			throw NetworkError.notFound
		case 500:
			throw NetworkError.serverError
		default:
			throw NetworkError.wrongCredentials
		}
	}
	
	func updateUser(firstName: String, lastName: String, latitude: Double, longitude: Double, mapString: String, mediaURL: String) async throws -> Bool {
		guard let url = Endpoint.updateLocation.url else { throw NetworkError.badURL }
		
		let studentToPost = Student(createdAt: Date().formatted(), firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, mapString: mapString, mediaURL: mediaURL, uniqueKey: UUID().uuidString)
		
		var req = URLRequest(url: url)
		req.httpMethod = "PUT"
		req.addValue("application/json", forHTTPHeaderField: "Content-Type")
		req.httpBody = try JSONEncoder().encode(studentToPost)
		
		let (data, response) = try await URLSession.shared.data(for: req)
		let res = response as! HTTPURLResponse
		
		switch res.statusCode {
		case 200:
			let decodedData = try? JSONDecoder().decode(UpdateStudent.self, from: data)
			
			if let _ = decodedData {
				return true
			} else {
				throw NetworkError.decodingError
			}
		case 404:
			throw NetworkError.notFound
		case 500:
			throw NetworkError.serverError
		default:
			throw NetworkError.wrongCredentials
		}
	}
	
	func handleErrorResponse(error: NetworkError) -> (String, Bool) {
		var networkError = ""
		
		switch error {
		case .badRequest:
			networkError = "400 - Bad Request"
		case .serverError:
			networkError = "500 - Internal Server Error"
		case .notFound:
			networkError = "404 - Resource not found"
		case .decodingError:
			networkError = "404 - Decoding Error"
		case .wrongCredentials:
			networkError = "Wrong email or password"
		case .badURL:
			networkError = "400 - Bad URL"
		}
		
		return (networkError, true)
	}
}
