//
//  UserService.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/04/09.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService {
    static let instance = UserService()
    private init() {}

    var currentUser: User?
    let auth = Auth.auth()
    
    func getCurrentUser( completion: @escaping () -> ())  {
        guard let user = auth.currentUser else {
            return
        } 
        
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        
        userRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = documentSnapshot?.data() else { return }
            self.currentUser = User.initFromData(data)
            
            completion()
        }
    }
}
