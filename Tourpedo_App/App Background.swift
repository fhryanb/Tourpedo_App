//
//  AppBackground.swift
//  App One Feb 23 2024
//
//  Created by Virgil Belcher on 3/9/24.
//

import Foundation
import SwiftUI

struct AppBackground: View {
    // Define your theme colors
      let colorTop = Color("Col4")
    
    //Color(red: 193/255, green: 200/255, blue: 208/255) // Light Grey
    let colorBottom = Color("Col2").opacity(0.8)
    
    //Color(red: 210/255, green: 192/255, blue: 177/255) // Taupe
      
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [colorTop, colorBottom]), startPoint: .top, endPoint: .bottom)
                   .edgesIgnoringSafeArea(.all)
    }
}

struct AppBackground_Previews: PreviewProvider {
    static var previews: some View {
        AppBackground()
    }
}
