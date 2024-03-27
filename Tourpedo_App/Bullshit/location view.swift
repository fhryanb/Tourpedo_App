

import SwiftUI
import MapKit


extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 42.354528, longitude: -71.068369)
  
}

struct MyMapView: View {
    @State private var searchResults: [MKMapItem] = []
    @State private var destinationOne: String = ""
    @State private var destinationTwo: String = ""
    
    func addLocation() {
        let newLocation = locations(id: UUID(), destinationOne: destinationOne, destinationTwo: destinationTwo)
        print(newLocation)
    }
    
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .parking,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
    var body: some View {
        
        VStack {
            Map {
                Annotation("Parking",coordinate: .parking) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.background)
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondary, lineWidth: 5)
                        Image(systemName: "car")
                            .padding(5)
                        
                    }
                }
                .annotationTitles(.hidden)
                
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                
            }
            .mapStyle(.standard(elevation: .realistic))
            .safeAreaInset(edge: .bottom) {
              /*  HStack {
                    Spacer()
                    BeantownButtons(searchResults: $searchResults)
                        .padding(.top)
                }
                .background(.thinMaterial)*/
            }
            
            VStack {
                Form {
                    TextField("Dest One", text: $destinationOne)
                    TextField("Dest Two", text: $destinationTwo)
                }
                .onSubmit {
                    search(for: destinationOne)
                    search(for: destinationTwo)
                }
                
                Button(action: addLocation){
                    Text("add location button")
                }
                
            }
            .background(.thinMaterial)
            
        
            
        }
    }
}


#Preview {
    MyMapView()
}


struct BeantownButtons: View {
    @Binding var searchResults: [MKMapItem]
    @State private var searchInput: String = ""
    @State var locations: String
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .parking,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
    
    var body: some View {
        HStack {
           /* Button {
                search(for: "playground")
            } label: {
                Label ("Playgrounds", systemImage: "figure.and.child.holdinghands")
            }
            .buttonStyle(.borderedProminent)*/
            
            TextField("Search location", text: $searchInput)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.search)
                .onSubmit {
                    search(for: searchInput)
                }
            
            Button {
                search(for: searchInput)
            } label: {
                Label("Beaches", systemImage: "magnifyingglass")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        
    }
}



struct locations: Identifiable, Codable {
    var id = UUID()
    var destinationOne: String
    var destinationTwo: String
    
    
}


