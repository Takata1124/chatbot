//
//  ChildAnswerCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/27.
//

import SwiftUI

struct ChildAnswerCellView: View {

    var dataModel: DataModel
    var movieViewModel: MovieViewModel

    var body: some View {
        
        HStack (spacing: 30) {
            
            Button {
                dataModel.flowCount += 1
                ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel).sendMessage(message: "はい")
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
                dataModel.flowCount += 0
                ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel).sendMessage(message: "いいえ")
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
    }
}

//struct ChildAnswerCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChildAnswerCellView()
//    }
//}
