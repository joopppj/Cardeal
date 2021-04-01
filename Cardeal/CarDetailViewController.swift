//
//  CarDetailViewController.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/03/29.
//

import UIKit
import Kingfisher
class CarDetailViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var sloganLabel: UILabel!
    //@IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var specDetailsLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = car.name
        
        sloganLabel.text = car.slogan
        specDetailsLabel.text = "🧭Top Speed: \(car.topSpeed) mph \n🔋Max Power: \(car.maxPower) hp \n🏎0-60 mph: \(car.mph060)s"
        introductionLabel.text = car.description
        payButton.setTitle("Pay \((car.price / 20).formatToPrice()) deposit to order", for: .normal)
        
        let firstImageURL = car.images[0]
        
        if let url = URL(string: firstImageURL){
            firstImage.layer.cornerRadius = 20
            firstImage.kf.indicatorType = .activity
            firstImage.kf.setImage(with: url)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let orderVC = segue.destination as? OrderViewController {
            orderVC.car = self.car
        }
    }
}

extension CarDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return car.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionImageViewCell", for: indexPath) as! CollectionImageViewCell
        let url = car.images[indexPath.row]
        cell.displayImageCell(url: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let firstImageURL = car.images[indexPath.item]
        
        if let url = URL(string: firstImageURL){
            firstImage.layer.cornerRadius = 20
            firstImage.kf.indicatorType = .activity
            firstImage.kf.setImage(with: url)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 131, height: 131)
    }
    
    
}
