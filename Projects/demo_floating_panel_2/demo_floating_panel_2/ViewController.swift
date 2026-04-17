

import UIKit
import MapKit

// MARK: - 3. MAIN MAP VIEW CONTROLLER
class ViewController: UIViewController {
    
    var mapView: MKMapView!
    var bottomSheet: NativeSheetController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Setup Map Nền
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        // Zoom vào San Francisco
        let sfRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(sfRegion, animated: false)
        
        // 2. Setup Bottom Sheet
        setupBottomSheet()
    }
    
    func setupBottomSheet() {
        bottomSheet = NativeSheetController()
        
        // Tạo nội dung bên trong
        let contentVC = SearchListViewController()
        
        // Quan trọng: Gán nội dung vào sheet
        bottomSheet.setContent(viewController: contentVC)
        
        // Quan trọng: Track scrollview để xử lý kéo mượt
        bottomSheet.trackScrollView(contentVC.tableView)
        
        // Thêm Bottom Sheet vào View Hierarchy
        addChild(bottomSheet)
        view.addSubview(bottomSheet.view)
        bottomSheet.view.frame = view.bounds
        bottomSheet.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomSheet.didMove(toParent: self)
    }
}
