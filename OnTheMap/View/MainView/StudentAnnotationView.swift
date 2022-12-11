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
	@State private var showInfoCard = false
	
    var body: some View {
		VStack(spacing: 0){
			Image(systemName: "map.circle.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 30, height: 30)
				.font(.headline)
				.foregroundColor(.white)
				.padding(6)
				.background(Color("UdacityColor"))
				.cornerRadius(36)
			Image(systemName: "triangle.fill")
				.resizable()
				.scaledToFit()
				.foregroundColor(Color("UdacityColor"))
				.frame(width: 10, height: 10)
				.rotationEffect(Angle(degrees: 180))
				.offset(y: -3)
		}.onTapGesture {
			showInfoCard.toggle()
		}
		.sheet(isPresented: $showInfoCard) {
			VStack {
				Text("\(firstName) \(LastName)")
					.fontWeight(.semibold)
					.padding()
				HStack{
					LinkView(textMessage: "\(url)", destinationURL: url)
				}
			}
			.presentationDetents([.height(200)])
		}
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
