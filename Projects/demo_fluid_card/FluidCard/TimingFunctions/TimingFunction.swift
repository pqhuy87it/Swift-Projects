// ... (Header bản quyền) ...

// [Giải thích]: Struct hỗ trợ tính toán tiến độ animation (easing)
// Giúp tạo ra chuyển động tự nhiên hơn thay vì tuyến tính (linear).
public struct TimingFunction {

    // MARK: - Properties

    // 2 điểm điều khiển xác định hình dạng đường cong Bezier
    var controlPoint1: CGPoint {
        didSet { updateUnitBezier() }
    }

    var controlPoint2: CGPoint {
        didSet { updateUnitBezier() }
    }

    var duration: CGFloat {
        didSet { updateEpsilon() }
    }

    // MARK: - Private Properties

    // Đối tượng tính toán toán học cốt lõi
    private var unitBezier: UnitBezier
    // Sai số cho phép (độ chính xác)
    private var epsilon: CGFloat

    // MARK: - Initialiser

    public init(controlPoint1: CGPoint, controlPoint2: CGPoint, duration: CGFloat = 1.0) {
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
        self.duration = duration
        self.unitBezier = .init(controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        self.epsilon = TimingFunction.epsilon(for: duration)
    }

    // MARK: - Public API

    /// [Giải thích]: Hàm quan trọng nhất.
    /// Nhận vào thời gian đã trôi qua (từ 0.0 đến 1.0).
    /// Trả về giá trị tiến độ thực tế dựa trên đường cong (cũng từ 0.0 đến 1.0).
    /// Ví dụ: input 0.5 (giữa thời gian) nhưng output có thể là 0.8 (chạy nhanh lúc đầu).
    func progress(at fractionComplete: CGFloat) -> CGFloat {
        return unitBezier.value(for: fractionComplete, epsilon: epsilon)
    }

    // MARK: - Private helpers

    mutating private func updateUnitBezier() {
        unitBezier = UnitBezier(controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }

    mutating private func updateEpsilon() {
        epsilon = TimingFunction.epsilon(for: duration)
    }
}

// MARK: - Static methods

private extension TimingFunction {
    // Tính toán độ sai số epsilon dựa trên thời gian animation
    static func epsilon(for duration: CGFloat) -> CGFloat {
        return CGFloat(1.0 / (200.0 * duration))
    }
}

// MARK: - Platform specific extensions

#if canImport(UIKit)

import UIKit

public extension TimingFunction {
    // Tiện ích khởi tạo từ UICubicTimingParameters có sẵn của UIKit
    init(timingParameters: UICubicTimingParameters, duration: CGFloat = 1.0) {
        self.init(
            controlPoint1: timingParameters.controlPoint1,
            controlPoint2: timingParameters.controlPoint2,
            duration: duration
        )
    }
}

#endif
