import Foundation
import SwiftUI

struct Vehicle: Identifiable, Codable, Hashable {
    var id: Int
    var vehicleName: String
    var vehicleMake: String
    var vehicleModel: String
    var vehicleYear: String
    var vehicleLocation: String
    var vehicleSleeps: Int
    var vehicleDailyRate: Double
    var vehicleType: String
    var vehicleDescription: String
    var vehicleRating: Double
    var imageName: String
    
}


var vehicles: [Vehicle] = load("vehicles.json")


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

