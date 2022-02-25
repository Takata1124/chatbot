//
//  ChatCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct ChatCellView: View {
    
    @State private var messageText = ""
    
    @ObservedObject var dataModel: DataModel
    @ObservedObject var movieViewModel: MovieViewModel
    
    var body: some View {
        HStack (spacing: 30) {

            Button {
                sendMessage(message: "はい")
            } label: {
                Text("はい")
            }
            .frame(width: 75)
            .font(.system(size: 18))
            .foregroundColor(.white)
            .padding(12)
            .background(Color.accentColor)
            .cornerRadius(8)
            
            
            Button {
                sendMessage(message: "いいえ")
            } label: {
                Text("いいえ")
            }
            .frame(width: 75)
            .font(.system(size: 18))
            .foregroundColor(.white)
            .padding(12)
            .background(Color.accentColor)
            .cornerRadius(8)
        }
        .padding()
    }
    
    func sendMessage(message: String) {
        withAnimation {
            dataModel.messages.append("[USER]" + message)
            self.messageText = ""

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    dataModel.messages.append(movieViewModel.getBotResponse(message: message))
                }
            }
        }
    }
}

//struct ChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatCellView()
//    }
//}
