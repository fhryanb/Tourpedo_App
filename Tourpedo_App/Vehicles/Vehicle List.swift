import SwiftUI

struct ScrollableVehicleListView: View {
    @EnvironmentObject var viewModel: ViewModel
    var vehicles: [Vehicle]
    @State private var hideNavBar = false
    //@State private var showingFilterView = false
    @State private var searchText = ""
    
    
    var filteredVehicles: [Vehicle] {
        if searchText.isEmpty {
            return vehicles
        } else {
            return vehicles.filter { vehicle in
                vehicle.vehicleName.localizedCaseInsensitiveContains(searchText) ||
                vehicle.vehicleMake.localizedCaseInsensitiveContains(searchText) ||
                vehicle.vehicleModel.localizedCaseInsensitiveContains(searchText)
                // Add other criteria as needed
            }
        }
    }
    
    var body: some View {
        
            NavigationStack {
                ZStack {
                    AppBackground()
                    VStack {
                        HStack {
                            CustomSearchBar(searchText: $searchText)
                            Button(action: {
                                viewModel.showingFiltersView = true
                            }) {
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                        .imageScale(.large)
                                     .padding()
                                        .foregroundColor(Color.white)
                                   
                            }
                            .accessibilityLabel("Filter Vehicles")
                            .sheet(isPresented: $viewModel.showingFiltersView) {
                                FilterView(isPresented: $viewModel.showingFiltersView)
                            }
                        }
                        //.padding(.horizontal)
                        ScrollView {
                            
                            VStack(spacing: 10) { // Adjust spacing as needed
                                ForEach(filteredVehicles, id: \.id) { vehicle in
                                    NavigationLink(destination: VehicleDetailsView(vehicle: vehicle)) {
                                        VehicleCard(vehicle: vehicle)
                                        
                                    }
                                }
                                .refreshable {
                                   // something
                                }
                                
                                /*ForEach(viewModel.filteredVehicles, id: \.id) { vehicle in
                                    NavigationLink(destination: VehicleDetailsView(vehicle: vehicle)) {
                                        VehicleCard(vehicle: vehicle)
                                    }
                                }*/

                                // .onAppear { self.hideNavBar = false }
                                // .onDisappear { self.hideNavBar = true }
                                .background(Color.clear)
                                .foregroundColor(.black)
                                
                                // .searchable(text: $searchText, prompt: "Search Vehicles")
                                
                            }
                           // .padding()
                            
                        }
                        
                        //  .navigationBarHidden(hideNavBar)
                        //.navigationTitle("Vehicles")
                    }
                    
                }
                
                
        }
           
    }
}


struct ScrollableVehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableVehicleListView(vehicles: vehicles).environmentObject(ViewModel())
    }
}



struct CustomSearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("Col1")) // Set your icon color

            TextField("Search Vehicles", text: $searchText)
                .foregroundColor(Color("Col3")) // Set your text color
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Customize as needed
                .padding(.leading, 8)

            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white) // Set your clear button color
                }
                .padding(.trailing, 8)
            }
        }
        .padding()
        //.background(Color("Col4")) // Customize background as needed
        .cornerRadius(5)
    }
}



struct FilterView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    let years: [String] = ["All", "2020", "2021", "2022", "2023"]


    
    var body: some View {
        NavigationView {
            Form {
                // Vehicle Type Picker
                Section(header: Text("Vehicle Type")) {
                    Picker("Select Vehicle Type", selection: Binding(
                        get: { viewModel.selectedVehicleTypeIndex ?? 0 },
                        set: { viewModel.selectedVehicleTypeIndex = $0 }
                    )) {
                        ForEach(0..<viewModel.vehicleTypes.count, id: \.self) { index in
                            Text(viewModel.vehicleTypes[index].name).tag(index)
                        }
                    }
                }
                
                // Vehicle Make Picker
                Section(header: Text("Vehicle Make")) {
                    if let typeIndex = viewModel.selectedVehicleTypeIndex, viewModel.vehicleTypes.indices.contains(typeIndex) {
                        Picker("Select Make", selection: Binding(
                            get: { viewModel.selectedMakeIndex ?? 0 },
                            set: { viewModel.selectedMakeIndex = $0 }
                        )) {
                            ForEach(0..<viewModel.vehicleTypes[typeIndex].makes.count, id: \.self) { makeIndex in
                                Text(viewModel.vehicleTypes[typeIndex].makes[makeIndex].name).tag(makeIndex)
                            }
                        }
                    } else {
                        Text("Please select a vehicle type first")
                    }
                }
                
                // Vehicle Model Picker
                Section(header: Text("Vehicle Model")) {
                    if let typeIndex = viewModel.selectedVehicleTypeIndex, let makeIndex = viewModel.selectedMakeIndex,
                       viewModel.vehicleTypes.indices.contains(typeIndex),
                       viewModel.vehicleTypes[typeIndex].makes.indices.contains(makeIndex) {
                        
                        Picker("Select Model", selection: $viewModel.selectedModel) {
                            ForEach(viewModel.vehicleTypes[typeIndex].makes[makeIndex].models, id: \.self) { model in
                                Text(model).tag(model)
                            }
                        }
                    } else {
                        Text("Please select a vehicle make first")
                    }
                }
                
                // Vehicle Year Picker
                Section(header: Text("Vehicle Year")) {
                    
                    Picker("Select Year", selection: $viewModel.selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(year).tag(year)
                        }
                    }
                    
                    
                    
                   /* Picker("Select Year", selection: $viewModel.selectedYear) {
                        ForEach($viewModel.years, id: \.self) { year in
                            Text(year).tag(year)
                        }
                    }*/
                }
                
                // Minimum Rating Slider
                Section(header: Text("Rating")) {
                    Slider(value: $viewModel.minimumRating, in: 0...5, step: 0.1) {
                        Text("Minimum Rating")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("5")
                    }
                    Text("Minimum Rating: \(viewModel.minimumRating, specifier: "%.1f")")
                }
                
                // Maximum Daily Rate Slider
                Section(header: Text("Daily Rate")) {
                    Slider(value: $viewModel.maximumDailyRate, in: 0...2000, step: 100) {
                        Text("Maximum Daily Rate")
                    } minimumValueLabel: {
                        Text("$0")
                    } maximumValueLabel: {
                        Text("$2000")
                    }
                    Text("Up to: $\(viewModel.maximumDailyRate, specifier: "%.0f")")
                }
                
                // Apply Filters Button
                Button("Apply Filters") {
                   // viewModel.applyFilters()
                    isPresented = false
                }
            }
            .navigationBarTitle("Filter Vehicles", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
            })
        }
    }
}



/*
struct FilterView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool

    // Filter criteria states
    @State private var selectedMake: String = ""
    @State private var selectedModel: String = ""
    @State private var selectedYear: String = ""
    @State private var minimumRating: Double = 0
    @State private var maximumDailyRate: Double = 1000
   
    //var vehicleTypes: [VehicleType] = []
    
    // Example data - replace with your actual data sources or view model properties
   // let makes: [String] = ["All", "Prevost", "Vanhool", "MCI", "Ford", "Mercedes",]
   // let models: [String] = ["All", "Model 1", "Model 2", "Model 3"]
    let years: [String] = ["All", "2020", "2021", "2022", "2023"]

    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("Filtering options")) {
                  /*  Picker("Select Type", selection: $viewModel.selectedMake) {
                        ForEach(viewModel.vehicleTypes, id: \.self) { type in
                            Text(type.name).tag(type.name)
                        }
                        // .pickerStyle(SegmentedPickerStyle())
                        
                    }*/
                    Picker("Select Vehicle Type", selection: $viewModel.selectedVehicleTypeIndex) {
                                      ForEach(0..<viewModel.vehicleTypes.count, id: \.self) { index in
                                          Text(viewModel.vehicleTypes[index].name).tag(index)
                                      }
                                  }
                 
                    
                    if let selectedMakeIndex = viewModel.selectedVehicleTypeIndex,
                                      selectedMakeIndex < viewModel.vehicleTypes.count {
                                      
                                       let selectedType = viewModel.vehicleTypes[selectedMakeIndex]
                                       
                                       // Ensure 'selectedMake' is correctly updated based on this Picker
                                       Picker("Select Make", selection: $viewModel.selectedMake) {
                                           ForEach(selectedType.makes, id: \.id) { make in
                                               Text(make.name).tag(make.name)
                                           }
                                       }
                                       
                                       // Corrected "Select Model" Picker
                                       // This assumes 'selectedMake' is correctly set to a valid make name.
                                       if let make = selectedType.makes.first(where: { $0.name == viewModel.selectedMake }) {
                                           Picker("Select Model", selection: $viewModel.selectedModel) {
                                               ForEach(make.models, id: \.self) { model in
                                                   Text(model).tag(model)
                                               }
                                           }
                                       }
                                   }
                    
                    
                    Picker("Select Year", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(year).tag(year)
                        }
                    }
                    
                    
                    // Section(header: Text("Rating")) {
                    Slider(value: $minimumRating, in: 0...5, step: 0.1) {
                        Text("Minimum Rating")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("5")
                    }
                    Text("Minimum Rating: \(minimumRating, specifier: "%.1f")")
                    
                    
                    // Section(header: Text("Daily Rate")) {
                    Slider(value: $maximumDailyRate, in: 0...2000, step: 100) {
                        Text("Maximum Daily Rate")
                    } minimumValueLabel: {
                        Text("$0")
                    } maximumValueLabel: {
                        Text("$2000")
                    }
                    Text("Up to: $\(maximumDailyRate, specifier: "%.0f")")
                }
                
                Button(action: {
                    viewModel.applyFilters()
                    viewModel.showingFiltersView.toggle()
                }) {
                    Text("Close and apply")
                }
                
            }
            .navigationBarTitle("Filter Vehicles", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                viewModel.applyFilters()
                isPresented = false
            })

        }
    }
}
*/
