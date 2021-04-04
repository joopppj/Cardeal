//
//  LoginViewController.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/03/26.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmailText: UITextField!
    @IBOutlet weak var loginPasswordText: UITextField!
    @IBOutlet weak var registerEmailText: UITextField!
    @IBOutlet weak var registerPasswordText: UITextField!
    @IBOutlet weak var registerConfirmText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginBClicked(_ sender: Any){
        
        guard let email = loginEmailText.text , let password = loginPasswordText.text else {
            customizedAlert(msg: "Please complete required fields.")
            return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            
            defer {
                self.activityIndicator.stopAnimating()
            }
            
            if error != nil {
                self.customizedAlert(msg: error!.localizedDescription)
                return
            }
            
            self.dismiss(animated: true)
        }
        
    }
    
    @IBAction func signupBClicked(_ sender: Any){
        
        guard let email = registerEmailText.text , !email.isEmpty ,
              let password = registerPasswordText.text , !password.isEmpty ,
              let confirmPassword = registerConfirmText.text , !confirmPassword.isEmpty else {
                customizedAlert(msg: "Please complete required fields.")
                return
            
        }
        
        if password != confirmPassword {
            // mismatch alert
            customizedAlert(msg: "Confirm password doesn't match")
            return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          // ...
            if let error = error {
                print(error.localizedDescription)
                self.customizedAlert(msg: error.localizedDescription)
                self.activityIndicator.stopAnimating()
                return
            }
            
            defer {
                self.activityIndicator.stopAnimating()
            }
            self.dismiss(animated: true)
            
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
