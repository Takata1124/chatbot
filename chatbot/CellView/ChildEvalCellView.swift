//
//  ChildEvalCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/27.
//

import SwiftUI

struct ChildEvalCellView: View {
    
    @State var enable: Bool = false
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center, spacing: 10) {
                
                ForEach(0..<6) { i in
                    
                    VStack(alignment: .center){
                        Text("\(i)")
                        Image(systemName: "star")
                            .font(.system(size: 30))
                            .onTapGesture {
                                enable = true
                            }
                    }
                }
//
                Button {
                    print("次へ")
                } label: {
                    Text("次へ")
                }
                .frame(width: 50)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(12)
                .background(Color.accentColor)
                .cornerRadius(8)
                .disabled(!enable)
            }
        }
    }
}

//struct ChildEvalCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChildEvalCellView()
//    }
//}
