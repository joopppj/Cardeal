//
//  CollectionImageViewCell.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/03/31.
//

import UIKit
import Kingfisher

class CollectionImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    func displayImageCell(url: String) {
        image.layer.cornerRadius = 10
        guard let url = URL(string: url) else { return }
        image.kf.indicatorType = .activity
        //print("DEBUG successfully set the image ")
        image.kf.setImage(with: url)
        
    }
}
