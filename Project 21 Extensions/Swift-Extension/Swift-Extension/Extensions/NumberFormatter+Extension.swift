
import Foundation

extension NumberFormatter {
    public static let standard: NumberFormatter = { () -> NumberFormatter in
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.japan
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
}
