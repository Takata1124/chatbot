//
//  InitialVIew.swift
//  chatbot
//
//  Created by t032fj on 2022/03/07.
//

import SwiftUI
import Firebase

struct InitialVIew: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        if authViewModel.tempCurrentUser == nil {
            
            SignUpVIew()
                
        } else {
            
            HomeView()
        }
    }
}

//struct InitialVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        InitialVIew()
//    }
//}
