//
//  AuthViewModel.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import Foundation
import Firebase
import UIKit

class AuthViewModel: NSObject, ObservableObject {

    private var tempCurrentUser: Firebase.User?
    
    override init() {
        if Auth.auth().currentUser != nil {
            
            tempCurrentUser = Auth.auth().currentUser
        }
    }
    
    func login() {
        
    }
    
    func register(username: String, mail: String, passward: String, uiImage: UIImage) {
        
        Auth.auth().createUser(withEmail: mail, password: passward) { res, err in
            
            if err != nil {
                print("error")
                return
            }

            guard let user = res?.user else { return }
            self.tempCurrentUser = user
            
            let data: [String: Any] = ["username": username,
                                       "mail": mail]
            
            Firestore.firestore().collection("users").document(self.tempCurrentUser!.uid).setData(data) {_ in
                print("save data")
            }
            
            guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return }
            
            let filename = NSUUID().uuidString
            let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
            
            ref.putData(imageData, metadata: nil) { _, err in
                if let err = err {
                    print("error")
                    return
                }
                
                print("success to update Image")
                
                ref.downloadURL { url, _ in
                    
                    guard let imageUrl = url?.absoluteString else { return }
                    
                    Firestore.firestore().collection("users").document(self.tempCurrentUser!.uid).updateData(["ImageUrl": imageUrl]) { _ in
                        print("update to url")
                    }
                }
            }
            
            print("success to register")
        }
    }
    
    func sendEmailConfiguration() {
        
    }
    
    func signout() {
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("SignOut Error: %@", signOutError)
        }
    }
}
