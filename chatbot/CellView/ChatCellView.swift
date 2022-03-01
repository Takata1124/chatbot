//
//  ChatCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct ChatCellView: View {
    
    @State var messageText: String = ""
    @ObservedObject var dataModel: DataModel
    @ObservedObject var movieViewModel: MovieViewModel
    
    var body: some View {
        
        ZStack {
            
            Group {
                if dataModel.flowCount == 0 {
                    
                    ChildAnswerCellView(
                        dataModel: dataModel, movieViewModel: movieViewModel)

                } else if dataModel.flowCount == 1 {
                    
                    ChildChatCellView(
                        messageText: $messageText, dataModel: dataModel, movieViewModel: movieViewModel)
                    
                } else if dataModel.flowCount == 2 {
                    
                    ChildEvalCellView()
                }else {
                    
                    ChildAnswerCellView(
                        dataModel: dataModel, movieViewModel: movieViewModel)
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
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
