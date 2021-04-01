//
//  OrderViewController.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/01.
//

import UIKit
import Kingfisher
class OrderViewController: UIViewController {
    
    @IBOutlet weak var purchaseDetailsLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var bankNumberLabel: UILabel!
    @IBOutlet weak var changeCardButton: UIButton!
    @IBOutlet weak var changeBankButton: UIButton!
    @IBOutlet weak var activitIndicator: UIActivityIndicatorView!
    @IBOutlet weak var orderButton: UIButton!
    
    @IBOutlet weak var selectCardView : UIView!
    @IBOutlet weak var selectBankView : UIView!
    
    
    var currentPaymentType: PaymentType?
    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set gif for card
        if let url = URL(string: "https://images.squarespace-cdn.com/content/v1/535e680de4b0eea56c05a375/1534759124396-PQWXEXPJH6M63E2LCEWD/ke17ZwdGBToddI8pDm48kJK3mcvIOeLizskKjQm6us5Zw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpzlwjm6X34tWy4lTcXB3rOirLYyefQ6RM7lHE_DY0CQ9IAX8v_JgONwBvQXZzM4ULA/Digitas_LBi_VISA_Skip_To_The_Good_Stuff.gif"){
            cardImage.layer.cornerRadius = 20
            cardImage.kf.indicatorType = .activity
            cardImage.kf.setImage(with: url)
        }
        
        // set gif for bank
        if let url = URL(string: "https://i.pinimg.com/originals/2d/6c/82/2d6c82abca3f8122667657544a5a889b.gif"){
            bankImage.layer.cornerRadius = 20
            bankImage.kf.indicatorType = .activity
            bankImage.kf.setImage(with: url)
        }
        
        let changeCardRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeCardTapped))
        let changeBankRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeBankTapped))
        selectCardView.addGestureRecognizer(changeCardRecognizer)
        selectBankView.addGestureRecognizer(changeBankRecognizer)
        
        //TODO 
        purchaseDetailsLabel.text = "Purchase Details: \ndeposit: \((car.price / 20).formatToPrice()) \n transaction fee: $10 \ntotal: \((car.price / 20).formatToPrice())"
    }
    
    @objc func changeCardTapped() {
        if currentPaymentType == .card {return}
        currentPaymentType = .card
        
        selectCardView.layer.borderColor = UIColor.blue.cgColor
        selectCardView.layer.borderWidth = 4
        
        selectBankView.layer.borderColor = UIColor.systemGray.cgColor
        selectBankView.layer.borderWidth = 2
        
        //change
        
    }
    
    @objc func changeBankTapped() {
        if currentPaymentType == .bank {return}
        currentPaymentType = .bank
        
        selectBankView.layer.borderColor = UIColor.blue.cgColor
        selectBankView.layer.borderWidth = 4
        
        selectCardView.layer.borderColor = UIColor.systemGray.cgColor
        selectCardView.layer.borderWidth = 2
    }
    
}

enum PaymentType{
    case card
    case bank
}
