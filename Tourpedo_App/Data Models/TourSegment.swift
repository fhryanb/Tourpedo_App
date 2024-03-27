//
//  TourSegment.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/27/24.
//

import Foundation
import SwiftUI

struct TourSegment: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var startLocation: String
    var endLocation: String
    var startDate: Date
    var endDate: Date
}
