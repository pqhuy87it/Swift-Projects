import Foundation

// MARK: - 2️⃣ BUG: Closure Retain Cycle
// File: ViewModels/UserViewModel.swift

class UserViewModel {
    var users: [String] = []
    var onUpdate: (() -> Void)?
    
    // 🐛 BUG: Timer giữ strong ref tới self qua closure
    private var refreshTimer: Timer?
    
    func startAutoRefresh() {
        refreshTimer = Timer.scheduledTimer(
            withTimeInterval: 30,
            repeats: true
        ) { _ in  // 🐛 BUG: capture self mạnh
            self.refreshData()
        }
    }
    
    func refreshData() {
        users.append("New User \(Int.random(in: 1...999))")
        onUpdate?()
    }
    
    deinit {
        refreshTimer?.invalidate()
        print("🟢 UserViewModel deinit")
    }
}
