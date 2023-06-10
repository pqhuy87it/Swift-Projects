//
//  DynamicContentUsingFlowLayoutController.swift
//  CollectionView
//
//  Created by huy on 2023/06/11.
//

import UIKit

class DynamicContentUsingFlowLayoutController: UIViewController {

    @IBOutlet weak var dynamicContentCollectionView: UICollectionView!
    private let dataSource = DynamicContentFlowLayoutDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.darkestBlue
        dynamicContentCollectionView.backgroundColor = UIColor.darkestBlue
        dynamicContentCollectionView.dataSource = dataSource
        dynamicContentCollectionView.contentInset = UIEdgeInsets(inset: 10.0)
        dynamicContentCollectionView.register(UINib(nibName: "DynamicContentFlowLayoutCell",bundle: nil), forCellWithReuseIdentifier: "cell")
        dynamicContentCollectionView.register(
            Header.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        dynamicContentCollectionView.register(
            Footer.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "footer"
        )
        let layout = FlexibleRowHeightGridLayout()
        layout.delegate = self
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        dynamicContentCollectionView.collectionViewLayout = layout
    }

}

extension DynamicContentUsingFlowLayoutController: FlexibleRowHeightGridLayoutDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: FlexibleRowHeightGridLayout,
        heightForItemAt indexPath: IndexPath
    ) -> CGFloat {
        guard let views = Bundle.main.loadNibNamed("DynamicContentFlowLayoutCell", owner: DynamicContentFlowLayoutCell.self, options: nil),
            let cell = views.first as? DynamicContentFlowLayoutCell else {
                return 0
        }
        cell.lbText.text = dataSource.item(at: indexPath)
        cell.contentView.layoutIfNeeded()
        let size = cell.contentView.systemLayoutSizeFitting(
            CGSize(width: layout.columnWidth(for: indexPath.section),
                   height: UIView.noIntrinsicMetric),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
        return size.height
        /*
         Or calculate height without inflating nib as follows:
         let text = dataSource.item(at: indexPath)
         let font = UIFont.preferredFont(forTextStyle: .title3)
         return layout.textHeight(text, font: font, in: indexPath.section)
         */
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: FlexibleRowHeightGridLayout,
        minimumInteritemSpacingForSectionAt: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: FlexibleRowHeightGridLayout,
        minimumLineSpacingForSectionAt: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: FlexibleRowHeightGridLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(inset: 10.0)
    }
    
    func numberOfColumns(for size: CGSize) -> Int {
        return 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: FlexibleRowHeightGridLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: layout.collectionViewContentSize.width, height: 100.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: FlexibleRowHeightGridLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: layout.collectionViewContentSize.width, height: 100.0)
    }
    
}
