

import Foundation

protocol IsCardRegisterAtApplePayInteractor {
    /**
     Return true if the card is currently registed at ApplePay, false othewise
     - Note: The card is registered at ApplePay if is currently enroll in
     all available paired device (iPhone/AppleWatch) linked with the device
     */
    func checkExist(_ card: Card) -> Bool
}
