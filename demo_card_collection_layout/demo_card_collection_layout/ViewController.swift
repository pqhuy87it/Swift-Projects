//
//  ViewController.swift
//  demo_card_collection_layout
//
//  Created by huy on 2025/12/27.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // Khởi tạo CollectionView bằng code (nếu bạn không dùng Storyboard)
        lazy var collectionView: UICollectionView = {
            let layout = CardsCollectionViewLayout()
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.backgroundColor = .white
            return cv
        }()
        
        // Dữ liệu màu sắc mẫu
        var colors: [UIColor] = [
            UIColor(red: 237, green: 37, blue: 78),
            UIColor(red: 249, green: 220, blue: 92),
            UIColor(red: 194, green: 234, blue: 189),
            UIColor(red: 1, green: 25, blue: 54),
            UIColor(red: 255, green: 184, blue: 209),
            UIColor.systemBlue,
            UIColor.systemOrange
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }
        
        func setupUI() {
            view.addSubview(collectionView)
            
            // AutoLayout cho CollectionView full màn hình
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            
            // Đăng ký Cell mặc định
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellReuseIdentifier")
        }
        
        // MARK: - UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return colors.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellReuseIdentifier", for: indexPath)
            
            // Bo góc và đổ màu cho thẻ
            cell.layer.cornerRadius = 15.0
            cell.layer.masksToBounds = true
            cell.backgroundColor = colors[indexPath.row % colors.count]
            
            return cell
        }
}

// Extension tiện ích để khởi tạo màu RGB (giữ lại từ code gốc)
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
}

