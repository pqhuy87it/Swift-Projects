//
//  DynamicContentController.swift
//  CollectionView
//
//  Created by huy on 2023/06/10.
//

import UIKit

class DynamicContentController: UIViewController {

    @IBOutlet weak var dynamicCollectionView: UICollectionView!
    
    private let dataSource = DynamicContentDataSource()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.darkestBlue
        dynamicCollectionView.backgroundColor = UIColor.darkestBlue
        dynamicCollectionView.register(UINib(nibName: "DynamicContentCell",bundle: nil), forCellWithReuseIdentifier: "cell")
        dynamicCollectionView.register(
            Header.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        dynamicCollectionView.register(
            Footer.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "footer"
        )
        dynamicCollectionView.delegate = self
        dynamicCollectionView.contentInset = UIEdgeInsets(inset: 10.0)
        dynamicCollectionView.dataSource = dataSource
        // this is center alignment
//        if let layout = dynamicCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
        
        // top alignment
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        dynamicCollectionView.collectionViewLayout = layout
    }
    
    
}


extension DynamicContentController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 100.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 100.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(inset: 10.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
}
