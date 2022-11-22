//
//  LinkView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import SwiftUI

struct LinkView: View {
	let textMessage : String
	let destinationURL : String
    var body: some View {
		Link(textMessage, destination: URL(string: destinationURL)!)
			.fontWeight(.light)
			.tint(Color("UdacityColor"))
			.frame(maxWidth: .infinity, alignment: .center)
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
		LinkView(textMessage: "Don't have an account? Sign Up", destinationURL: "https://auth.udacity.com/sign-in")
    }
}
