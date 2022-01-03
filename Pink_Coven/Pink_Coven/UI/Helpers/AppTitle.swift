//
//  AppTitle.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import SwiftUI

struct AppTitle: View {
    var body: some View {
        Text("Pink Coven")
            .font(.system(size: 48, weight: .bold, design: .rounded))
    }
}

struct AppTitle_Previews: PreviewProvider {
    static var previews: some View {
        AppTitle()
            .previewLayout(.sizeThatFits)
    }
}
