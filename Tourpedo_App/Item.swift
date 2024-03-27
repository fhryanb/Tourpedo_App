//
//  Item.swift
//  Tourpedo_App
//
//  Created by Ryan Belcher on 3/15/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
