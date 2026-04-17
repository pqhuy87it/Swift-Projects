
import Foundation
import PassKit

class InAppPassKitRepositoryImpl: InAppPassKitRepository {
    
    func isPassKitAvailable() -> Bool {
        return PKPassLibrary.isPassLibraryAvailable()
    }
    
    func passes() -> [PassKitItem] {
        // 1
        guard PKPassLibrary.isPassLibraryAvailable() else {
            return []
        }
        
        // 5
        return passes().compactMap(map(pkpass:))
    }
    
    func remotePasses() -> [PassKitItem] {
        guard PKPassLibrary.isPassLibraryAvailable() else {
            return []
        }
        
        // 6
        return remotePasses().compactMap(map(pkpass:))
    }
    
    /**
     Return the secureItems stored into PKPassLibrary
     */
    private func passes() -> [PKPass] {
        // 2
        let passLibrary = PKPassLibrary()
        if #available(iOS 13.4, *) {
            return passLibrary.passes(of: .secureElement)
        } else {
            return passLibrary.passes(of: .payment)
        }
    }
    
    /**
     Return the secureItems for paired devices stored into PKPassLibrary
     */
    private func remotePasses() -> [PKPass] {
        return PKPassLibrary().remotePaymentPasses()
    }
    
    /**
     Return the suffix (****-****-****-XXXX) of the pkpass item (if its
     represents a card)
     */
    private func deviceCardSuffix(for pass: PKPass) -> String? {
        // 3
        if #available(iOS 13.4, *) {
            return pass.secureElementPass?.primaryAccountNumberSuffix
        } else {
            return pass.paymentPass?.primaryAccountNumberSuffix
        }
    }
    
    /**
     Return the device account identifier related with the transaction of
     the PKPass item (if exists)
     */
    private func deviceAccountIdentifier(for pass: PKPass) -> String? {
        // 4
        if #available(iOS 13.4, *) {
            return pass.secureElementPass?.deviceAccountIdentifier
        } else {
            return pass.paymentPass?.deviceAccountIdentifier
        }
    }
    
    /**
     Return the prime account identifier related with the transaction of
     the PKPass item (if exists)
     */
    private func primaryAccountIdentifier(for pass: PKPass) -> String? {
        // 5
        if #available(iOS 13.4, *) {
            return pass.secureElementPass?.primaryAccountIdentifier
        } else {
            return pass.paymentPass?.primaryAccountIdentifier
        }
    }
    
    /**
     Map PKPass to PassKitItem (if possible)
     */
    private func map(pkpass: PKPass) -> PassKitItem? {
        guard let deviceAccountIdentifier = self.deviceAccountIdentifier(for: pkpass) else {
            return nil
        }
        
        guard let cardSuffix = self.deviceCardSuffix(for: pkpass) else {
            return nil
        }
        
        guard let primaryAccountIdentifer = self.primaryAccountIdentifier(for: pkpass) else {
            return nil
        }
        
        return PassKitItem(cardSuffix: cardSuffix,
                           deviceAccountIdentifier: deviceAccountIdentifier,
                           primaryAccountIdentifier: primaryAccountIdentifer)
    }
}
