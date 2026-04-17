
import UIKit

// [Giải thích]: Extension giúp viết ngắn gọn mã mask corner
extension CACornerMask {
    static var all: CACornerMask {
        return [.layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner,
                .layerMinXMaxYCorner]
    }
}

// [Giải thích]: Extension giúp dịch chuyển CGPoint dễ dàng hơn
extension CGPoint {
    func offsetBy(dx: CGFloat = 0, dy: CGFloat = 0) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
