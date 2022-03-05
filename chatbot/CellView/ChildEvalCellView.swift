//
//  ChildEvalCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/27.
//

import SwiftUI

struct ChildEvalCellView: View {
    
    var dataModel: DataModel
    var movieViewModel: MovieViewModel
    @Binding var isLoading: Bool
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center, spacing: 20) {
                
                Button {
                    print("次へ")
                } label: {
                    Text("レビュー投稿")
                }
                .frame(width: 150)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(8)
//                .disabled(!enable)

                Button {
                    print("次へ")
                    dataModel.flowCount += 1
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading).sendMessage(message: "次へ")
                } label: {
                    Text("詳細")
                }
                .frame(width: 50)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(8)
                
                Button {
                    print("次へ")
                    dataModel.flowCount += 1
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading).sendMessage(message: "次へ")
                } label: {
                    Text("他へ")
                }
                .frame(width: 50)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
    }
}

//struct ChildEvalCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChildEvalCellView()
//    }
//}
