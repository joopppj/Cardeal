//
//  Car.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/03/27.
//

import Foundation

struct Car {
    let name: String
    let description: String
    let images: [String]
    let topSpeed: Int
    let maxPower: Int
    let mph060: Double
    let price: Int
    let slogan: String
    let specDetails: String
    
    
    
    init(name: String, description: String, images: [String], topSpeed: Int, maxPower: Int, mph060: Double, price: Int, slogan: String, specDetails: String) {
        self.name = name
        self.description = description
        self.images = images
        self.topSpeed = topSpeed
        self.price = price
        self.slogan = slogan
        self.specDetails = specDetails
        self.maxPower = maxPower
        self.mph060 = mph060
    }
    
    init(data: [String: Any]) {
        self.price = data["price"] as? Int ?? 0
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.images = data["images"] as? [String] ?? [String]()
        self.topSpeed = data["topSpeed"] as? Int ?? 0
        self.slogan = data["slogan"] as? String ?? ""
        self.specDetails = data["specDetails"] as? String ?? ""
        self.maxPower = data["maxPower"] as? Int ?? 0
        self.mph060 = data["mph060"] as? Double ?? 0
    }
}
