//
//  SelfCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import SwiftUI

struct SelfCellView: View {
    
    let message: String
    
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
            
            Image(systemName: "person")
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
//        SelfCellView()
//    }
//}
