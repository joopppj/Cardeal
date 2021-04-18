//
//  StripeWallet.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/12.
//

import Foundation
import Stripe

class StripeWallet {
    static let instance = StripeWallet()
    private init() {}
    
    var customerContext: STPCustomerContext!
    
}
