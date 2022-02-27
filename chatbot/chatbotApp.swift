//
//  chatbotApp.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI
import Firebase

@main
struct chatbotApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            if Auth.auth().currentUser == nil {
                
                SignUpVIew().environmentObject(AuthViewModel())
            } else {
                HomeView().environmentObject(AuthViewModel())
            }
        }
    }
}
