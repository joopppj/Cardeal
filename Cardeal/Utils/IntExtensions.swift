//
//  IntExtensions.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/03/28.
//

import Foundation

extension Int {
    func formatToPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
        //let nsnum = NSNumber(integerLiteral: self / 1000)
    }
}
