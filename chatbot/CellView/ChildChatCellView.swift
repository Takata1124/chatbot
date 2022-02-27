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

    var body: some View {

        HStack {
            TextField("Type something", text: $messageText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .onSubmit {
                    dataModel.flowCount += 1
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel).sendMessage(message: messageText)
                }

            Button {
                dataModel.flowCount += 1
                ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel).sendMessage(message: messageText)
            } label: {
                Image(systemName: "paperplane.fill")
            }
            .font(.system(size: 26))
            .padding(.horizontal, 10)
        }
        .padding()
    }
}

//struct ChildChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChildChatCellView()
//    }
//}
