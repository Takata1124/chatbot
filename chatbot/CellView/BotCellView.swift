//
//  BotCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import SwiftUI

struct BotCellView: View {
    
    let message: String
    
    
    
    var body: some View {
        
        VStack {
            HStack {
                
                Image(uiImage: UIImage(named: "robot")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                
                Text(message)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(10)
                    .padding(.bottom, 10)

                Spacer()
            }
            
        }
    }
}

//struct BotCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        BotCellView(message: "message", dataModel: data)
//    }
//}
