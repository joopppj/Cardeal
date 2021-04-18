//
//  StripeClient.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/12.
//

import Foundation
import Stripe
import FirebaseFunctions

class MyAPIClient: NSObject, STPCustomerEphemeralKeyProvider {

    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let data = [
            "stripe_version": apiVersion,
            "customer_id": UserService.instance.currentUser?.stripeId] //as [String : Any]
        
        Functions.functions().httpsCallable("createEphemeralkey").call(data) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(nil, error) // problem
            }
            
            guard let json = result?.data as? [String: Any] else {
                return completion(nil, nil)
            }
            
            completion(json, nil)
        }
    }
}
