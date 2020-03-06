//
//  aboutView.swift
//  Bullseye
//
//  Created by Troy Arnold on 3/5/20.
//  Copyright © 2020 Troy Arnold. All rights reserved.
//

import SwiftUI

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
        .foregroundColor(Color.white)
        .font(Font.custom("Arial MT", size: 20))
    }
}

struct aboutView: View {
    var body: some View {
        VStack {
            Text("🎯 Bullseye 🎯 \n")
            Text("Drag the slider to try and match the bullseye value. \n")
            Text("The closer you are, the more points you get! \n")
            Text("Thank you for playing! \n")
            Text("Love, \n")
            Text("Yort Games")
            
        }
        .background(Image("Background"), alignment: .center)
    .modifier(LabelStyle())
        
    }
}

struct aboutView_Previews: PreviewProvider {
    static var previews: some View {
        aboutView().previewLayout(.fixed(width: 896, height: 414))

    }
}
