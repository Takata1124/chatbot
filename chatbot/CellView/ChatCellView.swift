//
//  ChatCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI
import PKHUD

struct ChatCellView: View {
    
    @State var messageText: String = ""
    @ObservedObject var dataModel: DataModel
    @ObservedObject var movieViewModel: MovieViewModel
    @Binding var isLoading: Bool
    @Binding var showingDetailSheet: Bool
    
    var body: some View {
        
        ZStack {
            
            showView()
        }
        .frame(height: 75)
    }
    
    func sendMessage(message: String) {
        
        isLoading = true
        
        withAnimation {
  
            dataModel.messages.append("[USER]" + message)
            self.messageText = ""

            movieViewModel.getBotResponse(message: message, nowCount: dataModel.flowCount, dataModel: dataModel) { message in
                dataModel.messages.append(message)
                isLoading = false
            }
        }
    }
    
    private func showView() -> AnyView {
        if dataModel.flowCount == 0 {
            
            return AnyView(ChildAnswerCellView(
                dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading, showingDetailSheet: $showingDetailSheet))

        } else if dataModel.flowCount == 1 {
            
            return AnyView(ChildYearCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading, showingDetailSheet: $showingDetailSheet))
            
        } else if dataModel.flowCount == 2 {
            
            return AnyView(ChildChatCellView(
                messageText: $messageText, dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading, showingDetailSheet: $showingDetailSheet))
        }else {
            
            return AnyView(ChildEvalCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading, showingDetailSheet: $showingDetailSheet))
        }
    }
}

//struct ChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatCellView()
//    }
//}
