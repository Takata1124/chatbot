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
    
    @Published var showingHomeSheet: Bool = false
    @Published var tempCurrentUser: Firebase.User?
    @Published var userData: User?
    
    override init() {
        super.init()
        
        if Auth.auth().currentUser != nil {
            
            self.tempCurrentUser = Auth.auth().currentUser
            self.fetchUserData()
        }
    }
    
    func login(mail: String, passward: String) {
        
        Auth.auth().signIn(withEmail: mail, password: passward) { res, err in
            if let err = err {
                print("signInError")
                return
            }
            
            guard let user = res?.user else { return }
            self.tempCurrentUser = user
            self.showingHomeSheet.toggle()
        }
    }
    
    func register(username: String, mail: String, passward: String, uiImage: UIImage) {
        
        Auth.auth().createUser(withEmail: mail, password: passward) { res, error in
            
            if let error = error {
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
            self.tempCurrentUser = nil
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print("SignOut Error: %@", signOutError)
        }
    }
    
    func fetchUserData() {
        
        guard let uid = tempCurrentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshots, error in
            
            if error != nil {
                return
            }
            
            guard let dic = snapshots?.data() else { return }
            let user = User.init(dic: dic)
            
            self.userData = user
            print(self.userData as Any)
        }
    }
}

