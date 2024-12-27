

import Foundation

struct Car: Codable, Identifiable {
    let id = UUID()
    let consList: [String]
    let customerPrice: Int
    let make: String
    let marketPrice: Int
    let model: String
    let prosList: [String]
    let rating: Int
    let image: String
}
