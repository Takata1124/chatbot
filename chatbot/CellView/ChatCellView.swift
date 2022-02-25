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
        
        Group {
            
            if dataModel.flowCount == 0 {
                
                HStack (spacing: 30) {
                    
                    Button {
                        dataModel.flowCount += 1
                        print(dataModel.flowCount)
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
            } else {
                
                HStack {
                    TextField("Type something", text: $messageText)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .onSubmit {
                            sendMessage(message: messageText)
                        }
                    
                    Button {
                        dataModel.flowCount += 1
                        print(dataModel.flowCount)
                        sendMessage(message: messageText)
                    } label: {
                        Image(systemName: "paperplane.fill")
                    }
                    .font(.system(size: 26))
                    .padding(.horizontal, 10)
                }
                .padding()
            }
            
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            dataModel.messages.append("[USER]" + message)
            movieViewModel.enTranslate(translatingText: message)
            self.messageText = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    dataModel.messages.append(movieViewModel.getBotResponse(message: message, nowCount: dataModel.flowCount))
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
