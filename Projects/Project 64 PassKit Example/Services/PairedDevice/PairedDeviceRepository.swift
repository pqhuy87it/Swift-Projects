

import Foundation

protocol PairedDeviceRepository {
    /**
     Return true if the device has a watch paired device linked. False othewise
     */
    func hasPairedWatchDevices() -> Bool
}
