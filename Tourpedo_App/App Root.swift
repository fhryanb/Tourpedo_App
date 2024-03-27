//
//  AppRoot.swift
//  App One Feb 23 2024
//
//  Created by Virgil Belcher on 3/14/24.
//

import Foundation
import SwiftUI

struct AppRoot: View {
    @EnvironmentObject var viewModel: ViewModel
 
    
    var body: some View {
        
        if viewModel.isLoggedIn {
            MainTabView()
        } else {
            LoginView()
        }
        
    }
}

struct AppRoot_Previews: PreviewProvider {
    static var previews: some View {
        AppRoot().environmentObject(ViewModel())
    }
}
