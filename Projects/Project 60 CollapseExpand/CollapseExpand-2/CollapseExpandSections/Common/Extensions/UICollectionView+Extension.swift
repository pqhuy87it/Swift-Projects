//
//  UICollectionView+Extension.swift
//  Swift-Extension
//
//  Created by HuyPQ22 on 2021/10/11.
//  Copyright © 2021 Huy Pham Quang. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCellByNib<T: UICollectionViewCell>(_ type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.identifier)
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_ type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(_ kind: String, type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: type.identifier,
                                                for: indexPath) as? T
    }
    
    /// SwifterSwift: Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
