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
        
        ZStack {
            
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

                } else {
                    
                    HStack {
                        TextField("Type something", text: $messageText)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .onSubmit {
                                dataModel.flowCount += 1
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
        .frame(height: 75)
    }
    
    func sendMessage(message: String) {
        withAnimation {
            
            dataModel.messages.append("[USER]" + message)
            self.messageText = ""
            
            print(message)
            
            let data: String = movieViewModel.getBotResponse(message: message, nowCount: dataModel.flowCount)
            print(data)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation {
                    
                    print(data)
                    dataModel.messages.append(data)
                    
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
