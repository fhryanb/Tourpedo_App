//
//  Vehicle Make Data Model.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/27/24.
//

import Foundation
import SwiftUI

struct VehicleMake: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var models: [String] // Assuming models are just names for simplicity
}
