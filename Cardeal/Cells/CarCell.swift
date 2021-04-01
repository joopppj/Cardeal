//
//  CarCell.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/03/27.
//
import UIKit
import Kingfisher
//import SDWebImage

class CarCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var topSpeedLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        // Initialization code
    }

    func displayCarCell(car: Car) {
        nameLabel.text = car.name
        priceLabel.text = "MSRP: \(car.price.formatToPrice())"
        topSpeedLabel.text = "\(car.topSpeed) mph"
        /*let imageUrl = car.images[0]
        
        if let url = URL(string: imageUrl) {
            
            mainImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            mainImage.sd_setImage(with: url, placeholderImage: UIImage(named: "background2"))
        }*/
        let firstImageURL = car.images[0]
        
        if let url = URL(string: firstImageURL){
            mainImage.kf.indicatorType = .activity
            mainImage.kf.setImage(with: url)
        }
    }
}
