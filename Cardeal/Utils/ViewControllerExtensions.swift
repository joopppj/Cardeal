//
//  ViewControllerExtensions.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/05.
//

import Foundation
import UIKit

extension UIViewController {
    func customizedAlert(title: String? = "Error", msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "close", style: .cancel)
        alert.addAction(closeAction)
        self.present(alert, animated: true)
    }
}
