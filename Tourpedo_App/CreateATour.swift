//
//  CreateATour.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/22/24.
//

import Foundation
import SwiftUI
import MapKit

struct CreateATourView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    @State private var tourName: String = ""
    @State private var tourStartDate: Date = Date()
    @State private var tourEndDate: Date = Date()
    @State private var tourStartLocation: String = ""
    @State private var tourEndLocation: String = ""
    @State private var segments: [TourSegment] = []
    @State private var showingSegmentEditor = false
    
    @State private var showingCreateTourView = false
    
    private func createTour() {
        let newTour = Tour(tourName: tourName, tourStartDate: tourStartDate, tourEndDate: tourEndDate, tourStartLocation: tourStartLocation, tourEndLocation: tourEndLocation, segments: segments)
        viewModel.tours.append(newTour)
        dismiss()
        viewModel.showingMyTours.toggle()
        viewModel.showContextMenu.toggle()
        resetForm()
        print(newTour)
        viewModel.rotatePlus()
        
    }
    
    private func resetForm() {
          tourName = ""
          tourStartDate = Date()
          tourEndDate = Date()
      }
      
    
    var body: some View {
        
        NavigationStack {
            
         //   if !viewModel.showingMyTours {
                
                Form {
                    Section(header: Text("Tour Info")) {
                        TextField("Name your tour", text: $tourName)
                        DatePicker("Start date", selection: $tourStartDate, displayedComponents: [.date])
                        DatePicker("End date", selection: $tourEndDate, displayedComponents: [.date])
                        
                        
                        TextField("Starting location", text: $tourStartLocation)
                        
                        TextField("Ending location", text: $tourEndLocation)
                    }
                    
                    Section(header: Text("Tour segments")) {
                        ForEach(segments) { segment in
                            Text(segment.name)
        
                            Button("Create tour"){
                                showingSegmentEditor = true
                            }
                        }
                        
                        
                        Button(action: createTour){
                            Text("Create")
                        }
                        .navigationTitle("Create a tour")
                        .sheet(isPresented: $showingSegmentEditor) {
                            SegmentEditorView(segments: $segments, startDate: tourStartDate, endDate: tourEndDate)
                        
                        }
                        
                    
                    }
                    ScrollView {
                        SegmentEditorView(segments: $segments, startDate: tourStartDate, endDate: tourEndDate)
                            .frame(height: 300)
                    }
                  
                }
                
                
               
                
               
                
        //    } else { MyTours() }
        
        }
        .onDisappear(perform: resetForm)
    }
}

#Preview {
    CreateATourView().environmentObject(ViewModel())
}

          
    
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
    


let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()


struct MyTours: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingCreateTourView = false
    
    var body: some View {
        
        List(viewModel.tours) { tour in
            VStack(alignment: .leading) {
                HStack {
                    Text(tour.tourName)
                        .font(.headline)
                    Spacer()
                }
                VStack(alignment: .leading) {
                        Text("Start: \(tour.tourStartDate, formatter: itemFormatter)")
                        Text("End: \(tour.tourEndDate, formatter: itemFormatter)")
                        Text("Starting location: \(tour.tourStartLocation)")
                        Text("Ending location: \(tour.tourEndLocation)")
                    VStack {
                      Text("shit here")
                    }
                    }
            }
        }
        .navigationTitle("Tours")
        //.toolbar {
          //  Button(action: { showingCreateTourView = true }) {
            //    Image(systemName: "plus")
           // }
      //  }
        .sheet(isPresented: $showingCreateTourView) {
           
            CreateATourView()
        }
        
    }
}

struct SegmentEditorView: View {
    @Binding var segments: [TourSegment]
    @Environment(\.dismiss) var dismiss

    @State var name: String = ""
    @State var description: String = ""
    @State var startLocation: String = ""
    @State var endLocation: String = ""
    @State var startDate: Date
    @State var endDate: Date
    
    private func addSegment() {
        let newSegment = TourSegment(name: name, 
                                     description: description,
                                     startLocation: "", 
                                     endLocation: "",
                                     startDate: Date(), 
                                     endDate: Date())
        segments.append(newSegment)
        dismiss()
    }

    var body: some View {
        VStack {
            VStack {
                TextField("Segment Name", text: $name)
                TextField("Description", text: $description)
                TextField("Start location", text: $startLocation)
                TextField("End location", text: $endLocation)
                DatePicker(selection: $startDate, displayedComponents: .date) {
                    Text("Start date")
                }
                Button("Add Segment", action: addSegment)
            }
            ForEach(segments) { segment in
                VStack {
                    VStack(alignment: .leading) {
                        Text("\(segment.id)")
                        Text(segment.name)
                        Text(segment.description)
                        Text("\(segment.startDate, formatter: itemFormatter)")
                        Text("\(segment.endDate, formatter: itemFormatter)")
                        Text(segment.startLocation)
                        Text(segment.endLocation)
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                }
            }
        }
    }
}
