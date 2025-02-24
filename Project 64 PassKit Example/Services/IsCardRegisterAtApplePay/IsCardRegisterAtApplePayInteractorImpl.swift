
import Foundation
import PassKit

class IsCardRegisterAtApplePayInteractorImpl: IsCardRegisterAtApplePayInteractor {
    
    private let pairedDeviceRepository: PairedDeviceRepository
    private let passKitRepository: InAppPassKitRepository
    
    init(pairedDeviceRepository: PairedDeviceRepository, passKitRepository: InAppPassKitRepository) {
        self.pairedDeviceRepository = pairedDeviceRepository
        self.passKitRepository = passKitRepository
    }
    
    func checkExist(_ card: Card) -> Bool {
        // 1
        let passes = passKitRepository.passes()
        let isEnrollLocally: Bool = isEnroll(card, into: passes)
        // 2
        let isEnrollRemotelly: Bool
        
        if pairedDeviceRepository.hasPairedWatchDevices() {
            // 3
            let remotePasses = passKitRepository.remotePasses()
            isEnrollRemotelly = isEnroll(card, into: remotePasses)
        } else {
            isEnrollRemotelly = true
        }
        
        // 4
        return isEnrollLocally && isEnrollRemotelly
    }
    
    /**
     Return true if we find a card with the same suffix located into a PassKitItem
     */
    private func isEnroll(_ card: Card, into passes: [PassKitItem]) -> Bool {
        let referenceCardSuffix = card.panToken.suffix(4)
        
        return passes.first { item -> Bool in
            return (item.cardSuffix == referenceCardSuffix) && (item.deviceAccountIdentifier == card.holder)
//            return (item.cardSuffix == referenceCardSuffix) && (item.primaryAccountIdentifier == card.holder)
        } != nil
    }
}
