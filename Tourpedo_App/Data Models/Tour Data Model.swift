//
//  Tour Data Model.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/22/24.
//

import Foundation
import SwiftUI

struct Tour: Identifiable, Codable {
    var id = UUID()
    var tourName: String
    var tourStartDate: Date
    var tourEndDate: Date
    var tourStartLocation: String
    var tourEndLocation: String
    var segments: [TourSegment]
}

