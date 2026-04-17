//
//  ItemViewB.swift
//  CollapseExpandStackView
//
//  Created by huy on 2023/07/23.
//

import UIKit

class ItemViewB: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    
    var collectionViewLayout: CustomLayout?
    var indexPath: IndexPath?
    
    var items = ["Hello",
                 "Look Behind",
                 "Gotta get there",
                 "Hey buddy",
                 "Earth is rotating around the sun",
                 "Sky is blue",
                 "Kill yourself",
                 "Humble docters",
                 "Lets make party tonight",
                 "Lets play PUB-G",
                 "Where are you?",
                 "Love you Iron Man."]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view from .xib file
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    func setup() {
        collectionView.register(UINib(nibName: "MyCell",bundle: nil), forCellWithReuseIdentifier: "MyCell")
        let myLayout =  CustomLayout()
        myLayout.array = self.items
        collectionView.collectionViewLayout = myLayout
        collectionView.isScrollEnabled = false
        
        self.collectionViewLayout = myLayout
    }
    
    func reloadData() {
        guard let myLayout = self.collectionViewLayout else {
            return
        }
        
        self.collectionView.performBatchUpdates({[weak self] in
            self?.collectionView.reloadData()
        }, completion: {[weak self] _ in
            self?.collectionViewHeightConstraint.constant = myLayout.collectionViewContentSize.height
        })
    }
}

extension ItemViewB: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
            cell.myLabel.text = items[indexPath.row]
            cell.myLabel.layer.borderColor = UIColor.lightGray.cgColor
            cell.myLabel.layer.borderWidth = 1

            return cell

        }
}
