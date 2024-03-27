//
//  MainTabView.swift
//  App One Feb 23 2024
//
//  Created by Virgil Belcher on 2/25/24.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var sheetOffset = UIScreen.main.bounds.height * 0.4
    @State private var isSheetOpen = false
    //@State private var showContextMenu = false
   // @State private var rotationAngle: Angle = .degrees(0)
    
   
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()
                VStack {
                    TabView {
                        ScrollableVehicleListView( vehicles: vehicles)
                            .tabItem {
                                Image(systemName: "sparkle.magnifyingglass")
                                Text("Search")
                            }
                        MyTours()
                            .tabItem {
                                Image(systemName: "list.bullet.rectangle.fill")
                                Text("My Tours")
                            }
                        Spacer()
                        InboxView()
                            .tabItem {
                                Image(systemName: "envelope.fill")
                                Text("Inbox")
                            }
                        FavoritesView()
                            .tabItem {
                                Image(systemName: "heart.fill")
                                Text("Favorites")
                            }
                        UserProfileView()
                            .tabItem {
                                Image(systemName: "person.circle.fill")
                                Text("Profile")
                            }
                        MyVehiclesView()
                            .tabItem {
                                Image(systemName: "bus")
                                Text("My Vehicles")
                            }
                        LogoutView()
                            .tabItem {
                                Label("Logout", systemImage: "arrow.backward.square")
                            }
                        }
                    }
                
                GeometryReader { geometry in
                    Button(action: {
                        print("Button tapped")
                        withAnimation {
                            viewModel.rotatePlus()
                        }
                        viewModel.showContextMenu.toggle()
                    }) {
                    ZStack {
                        Circle()
                            .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15) // Dynamic size based on screen width
                            .foregroundColor(Color("Col3"))
                                
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.075, height: geometry.size.width * 0.075) // Dynamic size based on screen width
                        .foregroundColor(.white)
                        .rotationEffect(viewModel.rotationAngle)
                        }
                    }
                    .position(x: geometry.size.width - (geometry.size.width * 0.53), y: geometry.size.height - (geometry.size.height * 0.1))
                    // Ensure the button is within safe areas
                    .padding()
                }
                .edgesIgnoringSafeArea(.all)
                
                if viewModel.showContextMenu {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                viewModel.showContextMenu .toggle()
                                viewModel.rotatePlus()
                            }
                        }
                    
                    GeometryReader { geometry in
                        ZStack {
                            VStack {
                                HStack {
                                    Text("Action Menu")
                                        .font(.title)
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            viewModel.rotatePlus()
                                        }
                                        viewModel.showContextMenu.toggle()
                                    }, label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: geometry.size.width * 0.05 , height: geometry.size.width * 0.05)
                                                .tint(Color.gray.opacity(0.5))
                                            Image(systemName: "xmark")
                                                .resizable()
                                                .frame(width: geometry.size.width * 0.025 , height: geometry.size.width * 0.025)
                                        }
                                    })
                                }
                                .padding()
                
                                VStack {
                                    NavigationLink(destination: CreateATourView() ) {
                                        ActionMenuButton(image: "star", optionName: "Create a tour", optionColor: Color.cyan)
                                    }.padding(.horizontal)
                                    
                                    NavigationLink(destination: AddAVehicleView()) {
                                        ActionMenuButton(image: "bus", optionName: "Add a vehicle", optionColor: Color.mint)
                                    }.padding(.horizontal)
                                }
                                .frame(width: .infinity, height: 170)
                                Spacer()
                            }
                            .frame(width: geometry.size.width * 1.00, height: geometry.size.width * 1.0)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .position(x: geometry.size.width - (geometry.size.width * 0.5), y: geometry.size.width - (geometry.size.width * -0.25))
                        }
                    }
                }
            }
            .accentColor(Color("Col4"))
            .background(Color("Col3"))
            .onAppear {
                // Access the UIColor version of your SwiftUI color defined in the asset catalog
                if let uiColor = UIColor(named: "Col1") {
                    UITabBar.appearance().backgroundColor = uiColor
                }
            }
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(ViewModel())
    }
}















/*
struct StartView: View {
    private var CircleSize: CGFloat = 60
    @State private var showPopover: Bool = false
    @State private var searchText = ""
    var body: some View {
        
       
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: CircleSize, height:CircleSize)
                .shadow(radius: 10)
                
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.blue) // Makes the image blue
                .font(.system(size: CircleSize))
                .onTapGesture {
                    self.showPopover.toggle()
                }
                .popover(isPresented: $showPopover) {
                    VStack{
                        HomeViewContextView()
                    }
                }
        }
  
    }
}


struct HomeViewContextView: View {
    @State private var showFiltersView: Bool = false
    @State private var menuItemWidth: CGFloat = 300
    @State private var menuItemHeight: CGFloat = 60
    
    var body: some View {
        NavigationStack {
            ZStack {
            AppBackground()
                VStack {
                    
                    NavigationLink("Create a tour") {
                        Text("context menu text")
                    }
                    .frame(width: menuItemWidth,height: menuItemHeight)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    /*NavigationLink("") {
                        Text("context menu text")
                    }
                    .frame(width: menuItemWidth,height: menuItemHeight)
                    .background(.white) */
                    
                    NavigationLink("Add a vehicle") {
                        AddAVehicleView()
                    }
                    .frame(width: menuItemWidth,height: menuItemHeight)
                    .background(Color("Col3"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                }
                
            }
            
            .navigationTitle("Lets go")
        }
        
    }
    
}*/
/*
struct SearchField: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var searchText: String
    
   // @State private var searchText = "" // probs delete this
    var body: some View {
        TextField("Search...", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                        
                    }
                    
                }
                
            )
            .padding(.horizontal)
         
    }
}


struct FiltersViewButton: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showFilters: Bool = false
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(.gray.opacity(0.2))
                .frame(width: 50, height: 50)
                .onTapGesture {
                    self.showFilters.toggle()
                }
                .popover(isPresented: $showFilters) {
                    Text("Filters view")
                    VStack {
                        // Filter UI
                        VStack {
                            HStack {
                                Text("Make:")
                                Picker("Select Make", selection: $viewModel.selectedMake) {
                                    Text("All").tag("All")
                                    // Add other makes as needed
                                    Text("Make1").tag("Make1")
                                    Text("Make2").tag("Make2")
                                }
                                .pickerStyle(MenuPickerStyle())
                                .onChange(of: viewModel.selectedMake) { _ in
                                    viewModel.applyFilters()
                                }
                            }
                            HStack {
                            Text("Minimum rating")
                            Slider(value: $viewModel.minimumRating, in: 0...5, step: 0.5) {
                                Text("Minimum Rating")
                            } minimumValueLabel: {
                                Text("0")
                            } maximumValueLabel: {
                                Text("5")
                            }
                            .onChange(of: viewModel.minimumRating) { _ in
                                viewModel.applyFilters()
                            }
                        }
                        }
                        .padding()
                        
                    }
                }
                    Image(systemName: "slider.horizontal.3")
                        .padding()
                    
                }
                .padding(.horizontal)
        }
    }
    
*/


