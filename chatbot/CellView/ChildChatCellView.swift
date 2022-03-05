//
//  ChildChatCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/27.
//

import SwiftUI

struct ChildChatCellView: View {

    @Binding var messageText: String
    var dataModel: DataModel
    var movieViewModel: MovieViewModel
    @Binding var isLoading: Bool

    var body: some View {

        HStack {
            TextField("Type something", text: $messageText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .onSubmit {
                    
                    sendMessage()   
                }

            Button {
                
                sendMessage()
            } label: {
                Image(systemName: "paperplane.fill")
            }
            .font(.system(size: 26))
            .padding(.horizontal, 10)
        }
        .padding()
    }
    
    private func sendMessage() {
        
        isLoading = true
        dataModel.flowCount += 1
        ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading).sendMessage(message: messageText)
    }
}

//struct ChildChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChildChatCellView()
//    }
//}
