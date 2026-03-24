// MARK: - 3️⃣ BUG: Closure capturing self trong escaping context
// File: Managers/ImageCacheManager.swift

import Foundation

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    // Giữ strong ref tới tất cả completion handlers
    private var pendingHandlers: [String: () -> Void] = [:]
    
    func preloadImage(
        for key: String,
        completion: @escaping () -> Void
    ) {
        // 🐛 BUG: Handler được lưu vĩnh viễn, không bao giờ remove
        pendingHandlers[key] = completion
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                completion()
                // Thiếu: self.pendingHandlers.removeValue(forKey: key)
            }
        }
    }
    
    var handlerCount: Int { pendingHandlers.count }
}
