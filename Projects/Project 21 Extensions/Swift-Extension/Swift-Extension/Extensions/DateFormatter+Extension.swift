
import Foundation

extension DateFormatter {
    public static let standard: DateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.calendar = Calendar.standard
        return formatter
    }()
}
