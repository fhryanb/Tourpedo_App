//
//  ActionMenuItem.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/22/24.
//

import Foundation
import SwiftUI

struct ActionMenuButton: View {
    let image: String
    let optionName: String
    let optionColor: Color
    
    init(image: String, optionName: String, optionColor: Color) {
        self.image = image
        self.optionName = optionName
        self.optionColor = optionColor
    }
    
    var body: some View {
    
        GeometryReader { geometry in
            NavigationStack {
                HStack {
                    ZStack {
                        Image(systemName: image)
                    }
                    .frame(width: 50, height: 50)
                    .background(optionColor)
                    .cornerRadius(10)
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text(optionName).font(.title2)
                    }
                    .padding(.trailing)
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.95 , height: 80)
                .background()
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
}

#Preview {
    ActionMenuButton(image: "star", optionName: "Create a tour", optionColor: Color.green)
}
