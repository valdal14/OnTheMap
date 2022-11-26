//
//  OnTheMapViewModifier.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 26/11/22.
//

import SwiftUI


struct TextFiledModifier: ViewModifier {
	
	func body(content: Content) -> some View {
		content
			.padding()
			.backgroundStyle(.gray)
			.cornerRadius(5.0)
	}
}

extension View {
	func onTheMapTextFieldModifier() -> some View { modifier(TextFiledModifier()) }
}


struct OnTheMapViewModifier: View {
	
	@State var binding = ""
	
    var body: some View {
        TextField("textfield", text: $binding)
			.onTheMapTextFieldModifier()
    }
}

struct OnTheMapViewModifier_Previews: PreviewProvider {
    static var previews: some View {
		OnTheMapViewModifier()
    }
}
