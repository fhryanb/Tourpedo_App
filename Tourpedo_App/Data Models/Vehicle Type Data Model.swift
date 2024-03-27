//
//  Vehicle Type Data Model.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/27/24.
//

import Foundation
import SwiftUI

struct VehicleType: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var makes: [VehicleMake]
}
