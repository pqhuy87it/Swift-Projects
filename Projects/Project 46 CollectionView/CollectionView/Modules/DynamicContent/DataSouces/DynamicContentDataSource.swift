//
//  DynamicContentDataSource.swift
//  CollectionView
//
//  Created by huy on 2023/06/10.
//

import Foundation
import UIKit

class DynamicContentDataSource: NSObject {
    
    private let strings = [
        0: [
            "Short text", "Short text", "Short text", "Some longer text which needs more room", "Short text",
            "Short text", "Short text",
            "This is a sentence which requires more space and therefore the height of the cell will be taller.",
            "Short text", "Short text", "Short text", "Short text", "Short text", "Short text", "Short text",
            "Short text", "Short text", "Short text", "Some longer text which needs more room.", "Short text",
            "Short text", "Short text"
        ],
        1: [
            "Short text", "Short text", "Short text", "Some longer text which needs more room", "Short text",
            "Short text", "Short text",
            "This is a sentence which requires more space and therefore the height of the cell will be taller.",
            "Short text", "Short text", "Short text", "Short text", "Short text", "Short text", "Short text",
            "Short text", "Short text", "Short text", "Some longer text which needs more room.", "Short text",
            "Short text", "Short text"
        ]
        ,
        2: [
            "Short text", "Short text", "Short text", "Some longer text which needs more room", "Short text",
            "Short text", "Short text",
            "This is a sentence which requires more space and therefore the height of the cell will be taller.",
            "Short text", "Short text", "Short text", "Short text", "Short text", "Short text", "Short text",
            "Short text", "Short text", "Short text", "Some longer text which needs more room.", "Short text",
            "Short text", "Short text"
        ]
    ]
    
    func item(at index: IndexPath) -> String {
        return strings[index.section]?[index.item] ?? ""
    }
    
    func numberOfItems(section: Int) -> Int {
        return strings[section]?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return strings.keys.count
    }
    
}

extension DynamicContentDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            guard let cell = dequeuedCell as? DynamicContentCell else { return dequeuedCell }
            let text = item(at: indexPath)
            cell.lbText.text = text
            switch text.count {
            case 0...10:
                cell.contentView.backgroundColor = .royalBlue
            case 11...40:
                cell.contentView.backgroundColor = .paleBlue
            default:
                cell.contentView.backgroundColor = .palestBlue
            }
            return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "header",
                for: indexPath
            )
        } else {
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: "footer",
                for: indexPath
            )
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(section: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
}
