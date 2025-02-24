

import Foundation
import PassKit
import WatchConnectivity

class PairedDeviceRepositoryImpl: PairedDeviceRepository {
  func hasPairedWatchDevices() -> Bool {
    // 5
    guard WCSession.isSupported() else {
        return false
    }
      
    let session = WCSession.default
      
    return session.isPaired
  }
}
