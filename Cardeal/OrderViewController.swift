//
//  OrderViewController.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/01.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseFunctions
import FirebaseAuth
import Stripe


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
    var paymentContext: STPPaymentContext!
    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStripe()
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
        let processingfee = processingFeesCal.calculateProcessingFee(subtotal: car.price / 20)
        
        purchaseDetailsLabel.text = "Purchase Details: \ndeposit: \((car.price / 20).formatToPrice()) \ntransaction fee: \(processingFeesCal.calculateProcessingFee(subtotal: car.price / 20).formatToPrice()) \ntotal: \(((car.price / 20)+processingfee).formatToPrice())"
    }
    //MARK: change card
    @objc func changeCardTapped() {
        setCardView()
        //change
        
    }
    
    @objc func setCardView() {
        if currentPaymentType == .card {return}
        currentPaymentType = .card
        
        selectCardView.layer.borderColor = UIColor.blue.cgColor
        selectCardView.layer.borderWidth = 4
        
        selectBankView.layer.borderColor = UIColor.systemGray.cgColor
        selectBankView.layer.borderWidth = 2
    }
    
    //MARK: change bank
    @objc func changeBankTapped() {
        setBankView()
    }
    
    @objc func setBankView() {
        if currentPaymentType == .bank {return}
        currentPaymentType = .bank
        
        selectBankView.layer.borderColor = UIColor.blue.cgColor
        selectBankView.layer.borderWidth = 4
        
        selectCardView.layer.borderColor = UIColor.systemGray.cgColor
        selectCardView.layer.borderWidth = 2
    }
    
    /*func setPurchaseDetails()  {
        
        let processingFee = processingFeesCal.calculateProcessingFee(subtotal: car.price);
        let total = processingFee+car.price;
        purchaseDetailsLabel.text="MSRP: \(car.price.formatToPrice())";
        
        
    
    }*/
    
    func setupStripe() {
        guard (UserService.instance.currentUser?.stripeId) != nil else {return}
        let config = STPPaymentConfiguration.shared
        paymentContext = STPPaymentContext(customerContext: StripeWallet.instance.customerContext, configuration: config, theme: .defaultTheme)
        paymentContext.hostViewController = self
        paymentContext.delegate = self
    }
    
    @IBAction func changeCardClicked(_ sender: Any) {
        if(self.paymentContext == nil){print("something goes wrong when accessing paymentcontext")}
        self.paymentContext.pushPaymentOptionsViewController()
    }
    
    @IBAction func changeBankClicked(_ sender: Any) {
        
    }
    
    @IBAction func orderClicked(_ sender: Any) {
        let total = (car.price / 20) + processingFeesCal.calculateProcessingFee(subtotal: car.price/20)

        let confirmPayment = UIAlertController(title: "Confirm Payment", message: "Confirm payment for \(total.formatToDecimalPrice())", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            self.paymentContext.requestPayment()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        confirmPayment.addAction(confirmAction)
        confirmPayment.addAction(cancel)
        present(confirmPayment, animated: true)
    }
    
}

extension OrderViewController: STPPaymentContextDelegate {
    // change ui after selecting credit card
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        if let card = paymentContext.selectedPaymentOption {
            cardNumberLabel.text=card.label
        } else {
            cardNumberLabel.text="No Card"
        }
    }
    // show alert when some error happens when reading card number.
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        customizedAlert(msg: "error reading card information")
    }
    
    // send payment request and information to stripe server
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
        print("Payment request started...")
        guard let stripeId = UserService.instance.currentUser?.stripeId  else {return}
        let uuid = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        let fees = processingFeesCal.calculateProcessingFee(subtotal: (car.price / 20))
        let total = (car.price / 20) + fees
        
        let data: [String: Any] = [
            "total": total,
            "idempotency": uuid,
            "customer_id": stripeId
        ]
        
        // send data and call cloud function
        Functions.functions().httpsCallable("createPaymentIntent").call(data) { (result, error) in
            if(error != nil){
                print(error!.localizedDescription)
                self.customizedAlert(msg: "error completing your payment")
                return
            }
            
            // receive the data stripe server kicked back
            guard let clientSecret = result?.data as? String else {
                self.customizedAlert(msg: "error completing your payment")
                return
            }
            
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
            paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
            
            // compare the patmentintent with the paymentcontext before to see if they match
            STPPaymentHandler.shared().confirmPayment(paymentIntentParams, with: paymentContext) {
                (status, paymentIntent, error) in
                switch status {
                case .succeeded:
                    completion(.success, nil)
                case .failed:
                    completion(.error, nil)
                case .canceled:
                    completion(.userCancellation, nil)
                }
                
            }
            
        }
    }
    // show alert when payment is finished
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        switch status {
        case .success:
            let successAlert = UIAlertController(title: "Payment Success!", message: "\nYou will receive an email with all the payment details soon!", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            successAlert.addAction(ok)
            present(successAlert, animated: true)
        case .error:
            customizedAlert(msg: "sorry, cannot complete your order.")
        case .userCancellation:
            return
        }
    }
    
    
}

enum PaymentType{
    case card
    case bank
}
