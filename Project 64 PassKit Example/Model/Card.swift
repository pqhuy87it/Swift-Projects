import Foundation

struct Card {
    /// `pan token` numeration for the card (****-****-****-0000)
    let panToken: String
    /// Last four digits of the `pan token` numeration for the card (****-****-****-0000)
    let panTokenSuffix: String
    /// Holder for the card
    let holder: String
}
