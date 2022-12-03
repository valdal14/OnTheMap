//
//  StudentAnnotationView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 3/12/22.
//

import SwiftUI

struct StudentAnnotationView: View {
	var firstName : String
	var LastName : String
	var url : String
	
    var body: some View {
		VStack {
			Text("\(firstName) \(LastName)")
				.fontWeight(.semibold)
			HStack{
				LinkView(textMessage: "\(url)", destinationURL: url)
				Spacer()
				Image(systemName: "info.circle.fill")
					.foregroundColor(Color("UdacityColor"))
			}
		}
		.padding()
    }
}

struct StudentAnnotationViewDark_Previews: PreviewProvider {
    static var previews: some View {
		StudentAnnotationView(firstName: "Valerio", LastName: "DAlessio", url: "http://www.canda.com")
			.preferredColorScheme(.dark)
    }
}

struct StudentAnnotationViewLight_Previews: PreviewProvider {
	static var previews: some View {
		StudentAnnotationView(firstName: "Valerio", LastName: "DAlessio", url: "http://www.canda.com")
			.preferredColorScheme(.light)
	}
}
