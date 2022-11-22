//
//  ListView.swift
//  OnTheMap
//
//  Created by Valerio D'ALESSIO on 22/11/22.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        Text("ListView")
    }
}

struct ListViewDark_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
			.preferredColorScheme(.dark)
    }
}

struct ListViewLight_Previews: PreviewProvider {
	static var previews: some View {
		ListView()
			.preferredColorScheme(.light)
	}
}
