//
//  FavoritesView.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/27/24.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
       
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 10) { // Adjust spacing as needed
                            ForEach(vehicles.filter { viewModel.favoritedVehicles.contains($0.id) }) { vehicle in
                                NavigationLink(destination: VehicleDetailsView(vehicle: vehicle)) {
                                    VStack {
                                        VehicleCard(vehicle: vehicle)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
