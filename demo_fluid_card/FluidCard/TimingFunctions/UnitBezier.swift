// ... (Header bản quyền: Ported from WebKit) ...

import CoreGraphics

// [Giải thích]: Struct tính toán đường cong Bezier đơn vị (Unit Bezier)
// Điểm đầu luôn là (0,0) và điểm cuối là (1,1).
public struct UnitBezier {

    // MARK: - Properties
    // Các hệ số của phương trình đa thức bậc 3
    private let ax: CGFloat
    private let bx: CGFloat
    private let cx: CGFloat

    private let ay: CGFloat
    private let by: CGFloat
    private let cy: CGFloat

    // MARK: - Initialiser

    public init(controlPoint1: CGPoint, controlPoint2: CGPoint) {

        // [Giải thích]: Tính toán các hệ số đa thức dựa trên 2 điểm điều khiển
        // Công thức: B(t) = (1-t)^3 P0 + 3(1-t)^2 t P1 + 3(1-t) t^2 P2 + t^3 P3
        // Ở đây P0=(0,0), P3=(1,1)
        
        cx = 3.0 * controlPoint1.x
        bx = 3.0 * (controlPoint2.x - controlPoint1.x) - cx
        ax = 1.0 - cx - bx

        cy = 3.0 * controlPoint1.y
        by = 3.0 * (controlPoint2.y - controlPoint1.y) - cy
        ay = 1.0 - cy - by
    }

    // MARK: - Methods

    // [Giải thích]: Tìm giá trị y (tiến độ animation) tại giá trị x (thời gian)
    // Quy trình: Giải phương trình tìm t tại x, sau đó thế t vào phương trình y.
    func value(for x: CGFloat, epsilon: CGFloat) -> CGFloat {
        return sampleCurveY(solveCurveX(x, epsilon: epsilon))
    }

    // Tính giá trị x tại tham số t
    func sampleCurveX(_ t: CGFloat) -> CGFloat {
        // Sử dụng quy tắc Horner để tính giá trị đa thức nhanh
        return ((ax * t + bx) * t + cx) * t
    }

    // Tính giá trị y tại tham số t
    func sampleCurveY(_ t: CGFloat) -> CGFloat {
        return ((ay * t + by) * t + cy) * t
    }

    // Tính đạo hàm của x theo t (dùng cho phương pháp Newton)
    func sampleCurveDerivativeX(_ t: CGFloat) -> CGFloat {
        return (3.0 * ax * t + 2.0 * bx) * t + cx
    }

    // [Giải thích]: Tìm giá trị tham số t sao cho sampleCurveX(t) xấp xỉ bằng x
    func solveCurveX(_ x: CGFloat, epsilon: CGFloat) -> CGFloat {
        var t0, t1, t2, x2, d2: CGFloat

        // Bước 1: Thử dùng phương pháp Newton-Raphson (nhanh hơn)
        t2 = x
        for _ in (0..<8) {
            x2 = sampleCurveX(t2) - x
            guard abs(x2) >= epsilon else { return t2 } // Đã đủ chính xác
            d2 = sampleCurveDerivativeX(t2)
            guard abs(d2) >= 1e-6 else { break } // Đạo hàm quá nhỏ, tránh chia cho 0
            t2 = t2 - x2 / d2
        }

        // Bước 2: Nếu Newton thất bại, dùng phương pháp chia đôi (Bisection) (chậm hơn nhưng đảm bảo hội tụ)
        t0 = 0.0
        t1 = 1.0
        t2 = x

        guard t2 >= t0 else { return t0 }
        guard t2 <= t1 else { return t1 }

        while t0 < t1 {
            x2 = sampleCurveX(t2)
            guard abs(x2 - x) >= epsilon else { return t2 }
            if x > x2 {
                t0 = t2
            } else {
                t1 = t2
            }
            t2 = (t1 - t0) * 0.5 + t0
        }

        // Không tìm thấy (hiếm khi xảy ra)
        return t2
    }
}
