//
//  YearCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/03/06.
//

import SwiftUI

struct ChildYearCellView: View {
    
    var dataModel: DataModel
    var movieViewModel: MovieViewModel
    @Binding var isLoading: Bool
    @Binding var showingDetailSheet: Bool

    var body: some View {
        
        VStack {
            HStack(alignment: .center, spacing: 30) {
 
                Button {
                    print("新しい")
                    dataModel.flowCount += 1
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading, showingDetailSheet: $showingDetailSheet).sendMessage(message: "新しい")
                } label: {
                    Text("新しい")
                }
                .frame(width: 70)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(8)
                
                Button {
                    print("次へ")
                    dataModel.flowCount += 1
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading, showingDetailSheet: $showingDetailSheet).sendMessage(message: "昔")
                } label: {
                    Text("昔")
                }
                .frame(width: 70)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
    }
    
}

//struct YearCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearCellView()
//    }
//}
