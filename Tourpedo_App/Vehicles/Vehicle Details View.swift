//
//  VehicleDetail.swift
//  Jan 25 BS
//
//  Created by Ryan Belcher on 1/26/24.
//

import Foundation
import SwiftUI


struct VehicleDetailsView: View {
    var vehicle: Vehicle
    @Environment(\.presentationMode) var presentationMode
    @State private var showingRentalRequestAlert = false
    @State private var showingAddFavoriteAlert = false
    
    func showRentalRequestAlert() { showingRentalRequestAlert = true }
    func showAddFavoriteAlert() { showingAddFavoriteAlert = true }
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
            Image(vehicle.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(maxWidth: .infinity, minHeight: 400, maxHeight: 400)
                .clipped()
            
                
            Divider()
            Text(vehicle.vehicleName)
                .font(.title)
            HStack {
                Text("\(vehicle.vehicleYear)")
                Text(vehicle.vehicleMake)
                Text(vehicle.vehicleModel)
            }
            Text(vehicle.vehicleType)
            Text("Number of beds: \(vehicle.vehicleSleeps)")
                
            Spacer()
                ScrollView {
                    Text("\(vehicle.vehicleDescription)")
                }
        }
        .padding()
        
            VStack{
               
                Button(action: showRentalRequestAlert) {
                    ActionMenuButton(image: "star", optionName: "Request rental", optionColor: .cyan)
                }
                .alert(isPresented: $showingRentalRequestAlert) {
                    Alert(
                        title: Text("Confirm"),
                        message: Text("Please form that you want to submit your request to rent this vehicle."),
                        primaryButton: .default(Text("Confirm")) {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        },
                        secondaryButton: .destructive(Text("Go back"))
                        )
                    }
            }
            .frame(height: 100)
            .padding()
            
        }
        .background(Color("Col1").opacity(0.1))
        .foregroundColor(Color("Col4"))
    }
}

struct VehicleDetails_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailsView(vehicle: vehicles[6])
    }
}

