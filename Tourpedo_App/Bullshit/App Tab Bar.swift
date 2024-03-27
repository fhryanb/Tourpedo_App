//
//  AppTabBar.swift
//  App One Feb 23 2024
//
//  Created by Virgil Belcher on 3/9/24.
//

import Foundation
import SwiftUI

struct AppTabBar: View {
    @State private var selectedTab = 0
    @State private var drawerOffset: CGFloat = 400
    @State private var isDrawerOpen = false
    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                case 0: ScrollableVehicleListView( vehicles: vehicles)
                case 1: MyTours()
//                case 2: HomeViewContextView()
                case 3: InboxView()
                case 4: FavoritesView()
                case 5: UserProfileView()
                default: ScrollableVehicleListView( vehicles: vehicles)
                }
            }
            
            // Spacer()
            VStack {
                VStack {
                VStack {
                    RoundedRectangle(cornerRadius: 5)
                                          .frame(width: 100, height: 5)
                                          .foregroundColor(.gray)
                                          .padding(10)
                }
                HStack {
                    Button(action: {
                        self.selectedTab = 0
                    }) {
                        VStack {
                            Image(systemName: "sparkle.magnifyingglass")
                                .frame(height: 10)
                            Text("Search")
                        }
                        .foregroundColor(selectedTab == 0 ? Color("Col4") : .gray)
                    }
                    .padding(.horizontal)
                    
                    
                    Button(action: {
                        self.selectedTab = 1
                    }) {
                        VStack {
                            Image(systemName: "folder.fill")
                                .frame(height: 10)
                            Text("Contracts")
                        }
                        .foregroundColor(selectedTab == 1 ? Color("Col4") : .gray)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        self.selectedTab = 2
                    }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .frame(height: 10)
                            Text("Create")
                        }
                        .foregroundColor(selectedTab == 2 ? Color("Col4") : .gray)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        self.selectedTab = 3
                    }) {
                        VStack {
                            Image(systemName: "envelope.fill")
                                .frame(height: 10)
                            Text("Inbox")
                        }
                        .foregroundColor(selectedTab == 3 ? Color("Col4") : .gray)
                    }
                    .padding(.horizontal)
                    
                }
                HStack {
                    
                    HStack {}.padding(.horizontal)
                    
                    Button(action: {
                        self.selectedTab = 4
                    }) {
                        VStack {
                            Image(systemName: "heart.fill")
                                .frame(height: 10)
                            Text("Favorites")
                        }
                        .foregroundColor(selectedTab == 4 ? Color("Col4") : .gray)
                    }
                    .padding(.horizontal)
                    
                    
                    Button(action: {
                        self.selectedTab = 5
                    }) {
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .frame(height: 10)
                            Text("Profile")
                        }
                        .foregroundColor(selectedTab == 5 ? Color("Col4") : .gray)
                    }
                    
                    HStack {}.padding(.horizontal)
                }
              Spacer()
            }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                           .background(Color.white) // Use your own color
                           .cornerRadius(20)
                           
                           .offset(y: self.drawerOffset)
                           .gesture(
                               DragGesture()
                                   .onChanged { gesture in
                                       let newPosition = gesture.translation.height
                                       // This checks if the drawer is being dragged upwards or is already open; then it moves accordingly
                                       if newPosition > 0 || self.isDrawerOpen {
                                           self.drawerOffset = newPosition + (self.isDrawerOpen ? 0 : 100) // Adjust starting offset here based on your UI
                                       }
                                   }
                                   .onEnded { gesture in
                                       // Snap behaviour: Determines whether the drawer should be open or closed after the drag ends
                                       if gesture.translation.height < 100 {
                                           self.drawerOffset = 0
                                           self.isDrawerOpen = true
                                       } else {
                                           self.drawerOffset = 100 // Adjust this based on your UI
                                           self.isDrawerOpen = false
                                       }
                                   }
                           )
                       }
                       .animation(.default, value: drawerOffset) // Smooth transition for the drawer movement
                   }
                   .edgesIgnoringSafeArea(.all)
               }
           }



struct AppTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBar().environmentObject(ViewModel())
    }
}
