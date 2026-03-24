// MARK: - 1️⃣ BUG: Strong Reference Cycle giữa 2 objects
// File: Models/NetworkService.swift

protocol NetworkServiceDelegate: AnyObject { // ✅ AnyObject cho weak
    func didFetchData(_ data: [String])
}
