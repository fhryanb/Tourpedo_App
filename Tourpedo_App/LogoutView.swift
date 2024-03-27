//
//  LogoutView.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/27/24.
//

import Foundation
import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showLogoutConfirmation: Bool = false
    
    var body: some View {
        ZStack {
            AppBackground()
            Button("Logout") {
                showLogoutConfirmation = true
            }
            .padding()
            .frame(width: 250)
            .background(Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert(isPresented: $showLogoutConfirmation) {
                Alert(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Log Out")) {
                        viewModel.isLoggedIn = false
                    },
                    secondaryButton: .cancel()
                )
            }
        }
       
    }
}
