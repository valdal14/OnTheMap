//
//  ButtonView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 20/11/22.
//

import SwiftUI

struct ButtonLoginView: View {
	let btnText: String
	let isValidForm: Bool
	let completion: () -> Void
	
    var body: some View {
		Button(btnText) {
			completion()
		}
		.frame(maxWidth: .infinity, alignment: .center)
		.buttonStyle(.borderedProminent)
		.buttonBorderShape(.roundedRectangle)
		.tint(Color("UdacityColor"))
		.foregroundColor(.white)
		.disabled(isValidForm == false)
    }
}

struct ButtonLoginView_Previews: PreviewProvider {
    static var previews: some View {
		ButtonLoginView(btnText: "Login", isValidForm: true, completion: { })
    }
}
