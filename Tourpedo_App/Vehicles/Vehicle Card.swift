
import Foundation
import SwiftUI

struct VehicleCard: View {
    @EnvironmentObject var viewModel: ViewModel
    var vehicle: Vehicle
 // @State private var isFavorite = false
    let cardTypeTwo = false
    var isFavorite: Bool {
          viewModel.isVehicleFavorited(vehicle)
      }
    var body: some View {
        
        if cardTypeTwo {
            //trying to come up with alternative card format
            VStack{
                HStack {
                    
                    Image(vehicle.imageName)
                        .resizable()
                        .cornerRadius(5)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                    
                    // .padding()
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Daily rate: $\(Int(vehicle.vehicleDailyRate))").font(.subheadline)
                            HStack {
                                Text(String(format: "%.1f", vehicle.vehicleRating))
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            .font(.subheadline)
                            .padding()
                        }
                        //   Spacer()
                        Text(vehicle.vehicleName).font(.title)
                        Spacer()
                        HStack{
                            Text(vehicle.vehicleYear)
                            Text(vehicle.vehicleMake)
                            Text(vehicle.vehicleModel)
                        }
                        .font(.callout)
                        
                    }
                    .frame(width: 225, height: 100)
                    
                }
            }
    
            
            
        } else {
            
            //   VStack { // card frame}
            VStack {
                ZStack { // imageframe
                    Image(vehicle.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                    
                    VStack {
                        HStack {
                            Spacer()
                            ZStack {
                                // Heart icon as an outline
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black.opacity(0.8))
                                    .onTapGesture {
                                        viewModel.isFavorite.toggle()
                                        viewModel.toggleFavorite(for: vehicle)
                                    }
                                
                            }
                            .padding()
                            
                        }
                        Spacer()
                    }
                }
                VStack {
                    HStack { // top row bottom card
                        HStack {
                            Text(String(format: "%.1f", vehicle.vehicleRating))
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal).font(.title3)
                        Spacer()
                        Text("Daily rate: $\(Int(vehicle.vehicleDailyRate))").padding(.horizontal).font(.title3)
                        
                    }
                    
                    VStack {
                        HStack {
                            Text(vehicle.vehicleName).font(.title)
                            Spacer()
                        }.padding(.horizontal)
                        HStack {
                            Text(vehicle.vehicleYear)
                            Text(vehicle.vehicleMake)
                            Text(vehicle.vehicleModel)
                            Spacer()
                        }.padding(.horizontal).font(.subheadline)
                        HStack {
                            Text(vehicle.vehicleLocation).font(.subheadline)
                            Spacer()
                        }.padding(.horizontal)
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 450)
            .background(.white.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 5, x: 5, y: 5)
            //  .padding(.horizontal)
            .foregroundColor(Color("Col3"))
            
        }
    }
}


struct VehicleCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        VehicleCard(vehicle: vehicles[19]).environmentObject(viewModel)
    }
}

