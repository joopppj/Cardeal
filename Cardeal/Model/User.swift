//
//  User.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/09.
//

import Foundation

struct User {
    var uid: String
    var stripeId: String
    var email: String
    
    static func initFromData(_ data: [String: Any]) -> User {
        let uid = data["id"] as? String ?? ""
        let stripeId = data["stripeId"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        
        return User(uid: uid, stripeId: stripeId, email: email)
    }
}
