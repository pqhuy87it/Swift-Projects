//
//  TopAlignedCollectionViewFlowLayout.swift
//  CollectionView
//
//  Created by huy on 2023/06/11.
//

import Foundation
import UIKit

open class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else { return nil }
        guard layoutAttributes.representedElementCategory == .cell else { return layoutAttributes }
        
        func layoutAttributesForRow() -> [UICollectionViewLayoutAttributes]? {
            guard let collectionView = collectionView else { return [layoutAttributes] }
            let contentWidth = collectionView.frame.size.width - sectionInset.left - sectionInset.right
            var rowFrame = layoutAttributes.frame
            rowFrame.origin.x = sectionInset.left
            rowFrame.size.width = contentWidth
            return super.layoutAttributesForElements(in: rowFrame)
        }
        
        let minYs = minimumYs(from: layoutAttributesForRow())
        guard let minY = minYs[layoutAttributes.indexPath] else { return layoutAttributes }
        layoutAttributes.frame = layoutAttributes.frame.offsetBy(dx: 0, dy: minY - layoutAttributes.frame.origin.y)
        return layoutAttributes
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]
        
        let minimumYs = minimumYs(from: attributes)
        attributes?.forEach {
            guard $0.representedElementCategory == .cell else { return }
            guard let minimumY = minimumYs[$0.indexPath] else { return }
            $0.frame = $0.frame.offsetBy(dx: 0, dy: minimumY - $0.frame.origin.y)
        }
        return attributes
    }
    
    /// Returns the minimum Y values based for each index path.
    private func minimumYs(from layoutAttributes: [UICollectionViewLayoutAttributes]?) -> [IndexPath: CGFloat] {
        layoutAttributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.reduce(into: [IndexPath: CGFloat]()) { result, line in
                line.1.forEach { result[$0.indexPath] = line.0 }
            } ?? [:]
    }
}
