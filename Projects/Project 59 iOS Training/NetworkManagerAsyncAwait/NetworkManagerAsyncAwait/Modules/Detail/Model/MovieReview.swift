import Foundation

struct MovieReview: Identifiable, Equatable, Codable {
    let id: String
    let author: String
    let content: String
}
