//
//  ViewController.swift
//  EffectLoadingImageView
//
//  Created by Pham Quang Huy on 12/10/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
            collectionView.backgroundColor = UIColor.grayColor()
        }
    }
    
    var items = [Item]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createData()
    }
    
    func createData() {
        let item = Item()
        item.imageURL = "https://static.pexels.com/photos/3247/nature-forest-industry-rails.jpg"
        items.append(item)
        
        let item2 = Item()
        item2.imageURL = "http://wpnature.com/wp-content/uploads/2016/09/forest-one-way-railroad-nature-wallpaper-green.jpg"
        items.append(item2)
        
        let item3 = Item()
        item3.imageURL = "http://wpnature.com/wp-content/uploads/2017/02/mountain-mount-fishtail-nepal-palpa-tasen-wallpaper-mac.jpg"
        items.append(item3)
        
        let item4 = Item()
        item4.imageURL = "http://wpnature.com/wp-content/uploads/2016/08/forest-foggy-rainy-road-bare-winter-fog-rain-hd-free-live-wallpaper.jpg"
        items.append(item4)
        
        collectionView.reloadData()
    }

    @IBAction func addPressed(sender: AnyObject) {
        collectionView.reloadData()
    }
    
}


//*****************************************************************
// MARK: - UICollectionViewDataSource
//*****************************************************************

extension ViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell  {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        cell.configCellWithItem(item)
        return cell
    }
}


//*****************************************************************
// MARK: - UICollectionViewDelegate
//*****************************************************************

extension ViewController:  UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSizeMake(self.view.frame.width, self.view.frame.width)
    }
}

