import UIKit
import MapKit

// MARK: - 3. Map View Controller (Màn hình chính)
class NativeMapViewController: UIViewController {
    
    var mapView: MKMapView!
    var sheetController: NativeSheetController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Setup Map
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        // Zoom vào 1 địa điểm
        let center = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: false)
        
        // 2. Setup Panel (Tự chế)
        setupSheet()
    }
    
    func setupSheet() {
        // Khởi tạo Panel Controller
        sheetController = NativeSheetController()
        
        // Khởi tạo Nội dung (List)
        let contentVC = NativeSearchContentVC()
        
        // Kết nối
        sheetController.setContent(vc: contentVC)
        sheetController.trackScrollView(contentVC.tableView) // Để cuộn mượt
        
        // Thêm Panel vào màn hình hiện tại
        addChild(sheetController)
        view.addSubview(sheetController.view)
        sheetController.view.frame = view.bounds // Panel phủ toàn màn hình (nhưng trong suốt)
        sheetController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sheetController.didMove(toParent: self)
    }
}
