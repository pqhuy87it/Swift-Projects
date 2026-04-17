
import Foundation

extension Calendar {
    public static let standard: Calendar = { () -> Calendar in
        let calendar = Calendar(identifier: .gregorian)
        return calendar
    }()
}
