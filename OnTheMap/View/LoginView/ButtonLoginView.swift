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
	let alignment: Alignment
	let completion: () -> Void

	
    var body: some View {
		Button(btnText) {
			completion()
		}
		.frame(maxWidth: .infinity, alignment: alignment)
		.buttonStyle(.borderedProminent)
		.buttonBorderShape(.roundedRectangle)
		.tint(Color("UdacityColor"))
		.foregroundColor(.white)
		.disabled(isValidForm == false)
		.padding()
    }
}

struct ButtonLoginView_Previews: PreviewProvider {
    static var previews: some View {
		ButtonLoginView(btnText: "Login", isValidForm: true, alignment: .center, completion: { })
    }
}
