//
//  ImageCell.swift
//  EffectLoadingImageView
//
//  Created by Pham Quang Huy on 12/10/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .ScaleAspectFill
            imageView.tintColor = UIColor.leftBubbleTintColor()
            imageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var loadingProgressView: MessageLoadingProgressView! {
        didSet {
            loadingProgressView.hidden = true
            loadingProgressView.backgroundColor = UIColor.clearColor()
        }
    }
    
    var loadingProgress: Double = 0 {
        willSet {
            if newValue == 1.0 {
                loadingProgressView.hidden = true
                
            } else {
                loadingProgressView.progress = newValue
                loadingProgressView.hidden = false
            }
        }
    }
    
    let imageFadeTransitionDuration: NSTimeInterval = 0.2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    func loadingWithProgress(progress: Double, image: UIImage?) {
        
        if progress >= loadingProgress {
            
            if loadingProgress == 1.0 {
                if progress < 1.0 {
                    return
                }
            }
            
            if progress <= 1.0 {
                loadingProgress = progress
                
                if progress == 1 {
                    if let image = image {
                        self.imageView.image = image
                    }
                    return
                }
            }
            
            if let image = image {
                UIView.transitionWithView(self, duration: imageFadeTransitionDuration, options: .TransitionCrossDissolve, animations: { [weak self] in
                    self?.imageView.image = image
                    }, completion: nil)
            }
        }
    }
    
    func configCellWithItem(item: Item) {
        loadingProgress = 0
        
        imageView.setImageItem(item, completion: {loadingProgress, image in
            SafeDispatch.async { [weak self] in
                self?.loadingWithProgress(loadingProgress, image: image)
            }
        })
    }
}
