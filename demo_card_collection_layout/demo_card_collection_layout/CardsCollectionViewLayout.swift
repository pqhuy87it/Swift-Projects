//
//  CardsCollectionViewLayout.swift
//  demo_card_collection_layout
//
//  Created by huy on 2025/12/27.
//

import Foundation
import UIKit

class CardsCollectionViewLayout: UICollectionViewLayout {
    
    // MARK: - Layout Configuration
    var itemSize: CGSize = CGSize(width: 200, height: 300) {
        didSet { invalidateLayout() }
    }
    
    var spacing: CGFloat = 10.0 {
        didSet { invalidateLayout() }
    }
    
    var maximumVisibleItems: Int = 4 {
        didSet { invalidateLayout() }
    }
    
    // MARK: - UICollectionViewLayout
    override var collectionView: UICollectionView {
        return super.collectionView!
    }
    
    override var collectionViewContentSize: CGSize {
        let collectionView = collectionView
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CGSize(width: collectionView.bounds.width * itemsCount, height: collectionView.bounds.height)
    }
    
    override func prepare() {
        super.prepare()
        let collectionView = collectionView
        assert(collectionView.numberOfSections == 1, "Multiple sections aren't supported!")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let collectionView = collectionView
        
        let totalItemsCount = collectionView.numberOfItems(inSection: 0)
        let minVisibleIndex = max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0)
        let maxVisibleIndex = min(minVisibleIndex + maximumVisibleItems, totalItemsCount)
        
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        
        var attributes: [UICollectionViewLayoutAttributes] = []
        
        for i in minVisibleIndex..<maxVisibleIndex {
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = computeLayoutAttributesForItem(indexPath: indexPath,
                                                           minVisibleIndex: minVisibleIndex,
                                                           contentCenterX: contentCenterX,
                                                           deltaOffset: CGFloat(deltaOffset),
                                                           percentageDeltaOffset: percentageDeltaOffset)
            attributes.append(attribute)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // MARK: - Helper Calculations
    private func computeLayoutAttributesForItem(indexPath: IndexPath,
                                                minVisibleIndex: Int,
                                                contentCenterX: CGFloat,
                                                deltaOffset: CGFloat,
                                                percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let visibleIndex = indexPath.row - minVisibleIndex
        
        attributes.size = itemSize
        let midY = self.collectionView.bounds.midY
        
        // Tính toán vị trí Center
        attributes.center = CGPoint(x: contentCenterX + spacing * CGFloat(visibleIndex),
                                    y: midY + spacing * CGFloat(visibleIndex))
        
        // Z-Index để thẻ trước đè lên thẻ sau
        attributes.zIndex = maximumVisibleItems - visibleIndex
        
        // Tính toán Transform (Scale)
        attributes.transform = transform(atCurrentVisibleIndex: visibleIndex, percentageOffset: percentageDeltaOffset)
        
        // Xử lý hiệu ứng khi lướt
        switch visibleIndex {
        case 0:
            // Thẻ đầu tiên di chuyển sang trái
            attributes.center.x -= deltaOffset
            break
        case 1..<maximumVisibleItems:
            // Các thẻ phía sau dịch chuyển lên trên
            attributes.center.x -= spacing * percentageDeltaOffset
            attributes.center.y -= spacing * percentageDeltaOffset
            
            // Thẻ cuối cùng mờ dần hiện ra
            if visibleIndex == maximumVisibleItems - 1 {
                attributes.alpha = percentageDeltaOffset
            }
            break
        default:
            attributes.alpha = 0
            break
        }
        
        return attributes
    }
    
    private func transform(atCurrentVisibleIndex visibleIndex: Int, percentageOffset: CGFloat) -> CGAffineTransform {
        var rawScale = 1 - (0.1 * CGFloat(visibleIndex))
        
        if visibleIndex != 0 {
            let delta = 0.1 * percentageOffset
            rawScale += delta
        }
        
        return CGAffineTransform(scaleX: rawScale, y: rawScale)
    }
}
