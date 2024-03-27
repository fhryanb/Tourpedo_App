import Foundation
import SwiftUI

struct AddAVehicleView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var selectedTypeIndex = 0
    @State private var selectedMakeIndex = 0
    @State private var selectedModelIndex = 0
    @State private var selectedYear = 2000
    @State private var vehicle = Vehicle(id: 1, vehicleName: "", vehicleMake: "", vehicleModel: "", vehicleYear: "", vehicleLocation: "", vehicleSleeps: 1, vehicleDailyRate: 0.0, vehicleType: "", vehicleDescription: "", vehicleRating: 0.0, imageName: "")
    
    
    private func addVehicle() {
        let newVehicle = Vehicle(
            id: vehicle.id,
            vehicleName: vehicle.vehicleName,
            vehicleMake: vehicle.vehicleMake,
            vehicleModel: vehicle.vehicleModel,
            vehicleYear: vehicle.vehicleYear,
            vehicleLocation: vehicle.vehicleLocation,
            vehicleSleeps: vehicle.vehicleSleeps,
            vehicleDailyRate: vehicle.vehicleDailyRate,
            vehicleType: vehicle.vehicleType,
            vehicleDescription: vehicle.vehicleDescription,
            vehicleRating: vehicle.vehicleRating,
            imageName: vehicle.imageName)
        
        
     //   if !vehicles.contains(where: { $0.id == vehicle.id }) {
            viewModel.vehicles.append(newVehicle)
      ///  }
        
       // if !viewModel.myVehicles.contains(where: { $0.id == vehicle.id }) {
            viewModel.myVehicles.append(newVehicle)
       // }
        
        
        print(newVehicle)
    }
    
    
    
    func saveImage(_ image: UIImage) -> String {
        //save logic here
        return "path/to/image"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Vehicle Information")) {
                    VStack {
                        HStack {
                            Text("Vehicle name")
                            Spacer()
                        }
                        TextField("Name your vehicle", text: $vehicle.vehicleName)
                    }
                    Picker("Select vehicle type", selection: Binding(
                        get: { selectedTypeIndex },
                        set: { newValue in
                            selectedTypeIndex = newValue
                            vehicle.vehicleType = viewModel.vehicleTypes[newValue].name
                            selectedMakeIndex = 0 // Reset make index
                            selectedModelIndex = 0 // Reset model index
                        })) {
                            ForEach(0..<viewModel.vehicleTypes.count, id: \.self) { index in
                                Text(viewModel.vehicleTypes[index].name).tag(index)
                            }
                        }
                    
                    Picker("Select make", selection: Binding(
                        get: { selectedMakeIndex },
                        set: { newValue in
                            selectedMakeIndex = newValue
                            vehicle.vehicleMake = viewModel.vehicleTypes[selectedTypeIndex].makes[newValue].name
                            selectedModelIndex = 0 // Reset model index
                        })) {
                            ForEach(0..<viewModel.vehicleTypes[selectedTypeIndex].makes.count, id: \.self) { index in
                                Text(viewModel.vehicleTypes[selectedTypeIndex].makes[index].name).tag(index)
                            }
                        }
                    
                    Picker("Select model", selection: Binding(
                        get: { selectedModelIndex },
                        set: { newValue in
                            selectedModelIndex = newValue
                            vehicle.vehicleModel = viewModel.vehicleTypes[selectedTypeIndex].makes[selectedMakeIndex].models[newValue]
                        })) {
                            ForEach(0..<viewModel.vehicleTypes[selectedTypeIndex].makes[selectedMakeIndex].models.count, id: \.self) { index in
                                Text(viewModel.vehicleTypes[selectedTypeIndex].makes[selectedMakeIndex].models[index]).tag(index)
                            }
                        }
                    
                    Picker("Select year", selection: Binding(
                        get: { selectedYear },
                        set: { newValue in
                            selectedYear = newValue
                            vehicle.vehicleYear = String(newValue)
                        })) {
                            ForEach(1900...2024, id: \.self) { year in
                                Text("\(year)").tag(year)
                            }
                        }
                    
                    Section {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                        
                        Button("Upload Image") {
                            showingImagePicker = true
                        }
                    }
                }
                
                Button("Save Vehicle") {
                    if let selectedImage = selectedImage {
                        let imageName = saveImage(selectedImage)
                        vehicle.imageName = imageName
                    }
                    addVehicle()
                    //viewModel.addVehicle(vehicle)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .navigationTitle("Add a Vehicle")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}

struct AddAVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddAVehicleView().environmentObject(ViewModel())
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
