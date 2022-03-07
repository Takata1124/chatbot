//
//  SelfCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import SwiftUI
import Kingfisher

struct SelfCellView: View {
    
    let message: String
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        HStack {
            Spacer()
            
            Text(message)
                .padding()
                .foregroundColor(Color.white)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(10)
//                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            
            KFImage(URL(string: authViewModel.userData!.ImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
        }
    }
}

//struct SelfCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelfCellView(message: "message")
//    }
//}
