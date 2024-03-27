//
//  MyVehiclesView.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/25/24.
//

import Foundation
import SwiftUI


struct MyVehiclesView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
      
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 10) {
                    
                    ForEach(viewModel.myVehicles, id: \.id) { vehicle in
                        NavigationLink(destination: VehicleDetailsView(vehicle: vehicle)) {
                            VehicleCard(vehicle: vehicle)
                        }
                    }
                }
            }
            .navigationTitle("My Vehicles")
        }
    }
}

#Preview {
    MyVehiclesView().environmentObject(ViewModel())
}
