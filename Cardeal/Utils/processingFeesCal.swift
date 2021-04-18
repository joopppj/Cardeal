//
//  processingFeesCal.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/15.
//

import Foundation


// calculator stripe processing fee
class processingFeesCal {
    private static let stripeCardFeePercent = 0.029
    private static let fixedFee = 30
    
    
    //return amount in cents
    static func calculateProcessingFee(subtotal: Int) -> Int {
        if subtotal == 0 {
            return 0
        }
        
        let realFee = Int (Double(subtotal) * stripeCardFeePercent) + fixedFee
        
        return realFee
    }
     
}
