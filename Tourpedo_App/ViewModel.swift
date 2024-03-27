import Foundation
import Combine
import SwiftUI

class ViewModel: ObservableObject {
    
    // Vehicle data model
    @Published var vehicles: [Vehicle] = []
    @Published var myVehicles: [Vehicle] = []
    @Published var isFavorite: Bool = false // Changed to camelCase
    @Published var favoritedVehicles: Set<Int> = []
    @Published var filteredVehicles: [Vehicle] = []
    
    // Tour data model
    @Published var tours: [Tour] = []
    @Published var showingMyTours: Bool = false
    @Published var showCreateATour: Bool = false
    
    // User login
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    
    // Filtering vehicles
    @Published var selectedMake: String = "All"
    @Published var minimumRating: Double = 0.0
    @Published var maximumDailyRate: Double = 2000.0
    @Published var vehicleTypes: [VehicleType] = []
    @Published var selectedYear: String? = nil
    @Published var selectedModel: String = "All"
    @Published var selectedVehicleType: String = "All"
    @Published var showingFiltersView: Bool = false
    @Published var selectedVehicleTypeIndex: Int? = nil
    @Published var selectedMakeIndex: Int? = nil
    @Published var searchText: String = ""
    
    // Map
    
    
    
    
    // Menu items
    @Published var rotationAngle: Angle = .degrees(0)
    @Published var showContextMenu: Bool = false
    
    func rotatePlus() {
        if showContextMenu {
            rotationAngle = .degrees(0)
        } else {
            rotationAngle += .degrees(-45)
        }
    }
    
    
    
    init() {
        loadVehicleTypes()
    }

    
    
    
    
    func applyFilters() {
        filteredVehicles = vehicles.filter { vehicle in
            // Assuming vehicleType is determined by a combination of selectedVehicleTypeIndex and your data structure
            let selectedType = selectedVehicleTypeIndex != nil ? vehicleTypes[selectedVehicleTypeIndex!].name : "All"

            let matchesType = selectedType == "All" || vehicle.vehicleType == selectedType
            let matchesMake = selectedMake == "All" || vehicle.vehicleMake == selectedMake
            let matchesModel = selectedModel == "All" || vehicle.vehicleModel == selectedModel
            let matchesYear = selectedYear == "All" || vehicle.vehicleYear == selectedYear
            let matchesRating = vehicle.vehicleRating >= minimumRating
            let withinMaxDailyRate = vehicle.vehicleDailyRate <= maximumDailyRate
            
            return matchesType && matchesMake && matchesModel && matchesYear && matchesRating && withinMaxDailyRate
        }
    }

    
   /* func applyFilters() {
        filteredVehicles = vehicles.filter { vehicle in
            let matchesType = selectedVehicleType == "All" || vehicle.vehicleType == selectedVehicleType
            let matchesMake = selectedMake == "All" || vehicle.vehicleMake == selectedMake
            let matchesModel = selectedModel == "All" || vehicle.vehicleModel == selectedModel
            let matchesYear = selectedYear == nil || vehicle.vehicleYear == selectedYear
            let matchesRating = vehicle.vehicleRating >= minimumRating
            let withinMaxDailyRate = vehicle.vehicleDailyRate <= maximumDailyRate
            
            return matchesType && matchesMake && matchesModel && matchesYear && matchesRating && withinMaxDailyRate
        }
    }*/

    /*
    func toggleFavorite(for vehicle: Vehicle) {
        if let index = favoritedVehicles.firstIndex(where: { $0.id == vehicle.id }) {
            favoritedVehicles.remove(at: index)
        } else {
            favoritedVehicles.append(vehicle)
        }
    }*/
    
    func toggleFavorite(for vehicle: Vehicle) {
        if favoritedVehicles.contains(vehicle.id) {
            favoritedVehicles.remove(vehicle.id)
        } else {
            favoritedVehicles.insert(vehicle.id)
        }
    }
    
    func isVehicleFavorited(_ vehicle: Vehicle) -> Bool {
          favoritedVehicles.contains(vehicle.id)
      }
  
    
    private func loadVehicleTypes() {
        vehicleTypes = [
            VehicleType(name: "Band bus", makes: [
                VehicleMake(name: "Prevost", models: ["H3-40", "H3-41", "H3-45", "H3-45 VIP", "H5-60", "XL", "Le Mirage XL", "XL-45", "X3-45"]),
                VehicleMake(name: "VanHool", models: ["TDX25 Astromega", "T16 acron", "Tdx17 Altano", "CX-45", "TDX"])
            ]),
            VehicleType(name: "Star coach", makes: [
                VehicleMake(name: "Prevost", models: ["H3-40", "H3-41", "H3-45", "H3-45 VIP", "H5-60", "XL", "Le Mirage XL", "XL-45", "X3-45"]),
                VehicleMake(name: "VanHool", models: ["TDX25 Astromega", "T16 acron", "Tdx17 Altano", "CX-45", "TDX"])
            ]),
            VehicleType(name: "RV/Conversion", makes: [
                VehicleMake(name: "Coachmen", models: ["Encore", "Sportscoach rd", "Adrenaline", "Mirada", "Catalina Express"])
            ])
        ]
    }
    
    // Consider re-adding and refactoring the commented-out `filterVehicles` function here if needed, ensuring it's streamlined and fits with the new structure.
}






/*
import Foundation
import Combine
import SwiftUI

class ViewModel: ObservableObject {
   
    @Published var vehicles: [Vehicle] = []
    @Published var IsFavorite: Bool = false
    @Published var favoritedVehicles: [Vehicle] = []
    @Published var filteredVehicles: [Vehicle] = []

    
    //user login
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    
    // for filtering
    @Published var selectedMake: String = "All"
    @Published var minimumRating: Double = 0.0
    @Published var maximumDailyRate: Double = 2000.0
    @Published var vehicleTypes: [VehicleType] = []
    @Published var selectedTypeIndex: Int? = nil
    @Published var selectedMakeIndex: Int? = nil
    @Published var selectedYear: String? = nil
    @Published var selectedModel: String = "All"
    
    init() {
        self.filteredVehicles = self.vehicles
           vehicleTypes = [
               VehicleType(name: "Band bus", makes: [] + [
                   VehicleMake(name: "Prevost", models: ["H3-40", "H3-41", "H3-45", "H3-45 VIP", "H5-60", "XL", "Le Mirage XL", "XL-45", "X3-45"]),
                   VehicleMake(name: "VanHool", models: ["TDX25 Astromega", "T16 acron", "Tdx17 Altano", "CX-45", "TDX"])
               ]),
               VehicleType(name: "Star coach", makes: [
                   VehicleMake(name: "Prevost", models: ["H3-40", "H3-41", "H3-45", "H3-45 VIP", "H5-60", "XL", "Le Mirage XL", "XL-45", "X3-45"]),
                   VehicleMake(name: "VanHool", models: ["TDX25 Astromega", "T16 acron", "Tdx17 Altano", "CX-45", "TDX"])
               ]),
               VehicleType(name: "RV/Conversion", makes: [
                    VehicleMake(name: "Coachmen", models: ["Encore", "Sportscoach rd", "Adrenaline", "Mirada", "Catalina Express"])
                ])
               
               // Add more types, makes, and models as needed
           ]
       }
    
    func applyFilters() {
        filteredVehicles = vehicles.filter { vehicle in
            let matchesMake = selectedMake == "All" || vehicle.vehicleMake == selectedMake
            let matchesModel = selectedModel == "All" || vehicle.vehicleModel == selectedModel
            let matchesYear = selectedYear == "All" || vehicle.vehicleYear == selectedYear
            let matchesRating = vehicle.vehicleRating >= minimumRating
            let withinMaxDailyRate = vehicle.vehicleDailyRate <= maximumDailyRate

            return matchesMake && matchesModel && matchesYear && matchesRating && withinMaxDailyRate
        }
    }


    
    func typeChanged() {
           selectedMakeIndex = nil
           // Additional logic to handle model resetting
       }
  
 
    
    func toggleFavorite(for vehicle: Vehicle) {
          if let index = favoritedVehicles.firstIndex(where: { $0.id == vehicle.id }) {
              favoritedVehicles.remove(at: index)
          } else {
              favoritedVehicles.append(vehicle)
          }
      }
    
  /*  func filterVehicles(searchTerm: String) {
            if searchTerm.isEmpty {
                filteredVehicles = vehicles
            } else {
                filteredVehicles = vehicles.filter {
                    $0.vehicleName.localizedCaseInsensitiveContains(searchTerm) ||
                    $0.vehicleMake.localizedCaseInsensitiveContains(searchTerm) ||
                    $0.vehicleModel.localizedCaseInsensitiveContains(searchTerm) ||
                    $0.vehicleYear.contains(searchTerm) ||
                    $0.vehicleLocation.localizedCaseInsensitiveContains(searchTerm) ||
                    "\($0.vehicleSleeps)".contains(searchTerm) ||
                    "\($0.vehicleDailyRate)".contains(searchTerm) ||
                    $0.vehicleType.localizedCaseInsensitiveContains(searchTerm) ||
                    $0.vehicleDescription.localizedCaseInsensitiveContains(searchTerm) ||
                    "\($0.vehicleRating)".contains(searchTerm)
                }
            }
        }
    */

    
}
*/
