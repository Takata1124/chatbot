//
//  PostCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/26.
//

import SwiftUI
import Kingfisher

struct PostCellView: View {
    
    var data: PostDataArray?
    
    init(data: PostDataArray) {
        
        self.data = data
    }
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.pink.opacity(0.8))
                    .overlay(
                        
                        HStack {
                            VStack {
                                HStack (alignment: .center){
                                    
                                    KFImage(URL(string: data!.imageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100)
                                    
                                    VStack (alignment: .leading, spacing: 20) {
                                        HStack {
                                            Text(data!.title)
                                                .foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "multiply.circle")
                                                .onTapGesture {
                                                    print("tap")
                                                }
                                        }
    
                                        Text(data!.category)
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                            .frame(maxWidth: .infinity, alignment: .leading)

                                        HStack {
                                            HStack {
                                                ForEach(0..<data!.star) { i in
                                                    Image(systemName: "star.fill")
                                                        .font(.system(size: 14))
                                                }
                                                
                                                Spacer()
                                            }
                                        }
                                        HStack {
                                            
                                            Spacer()
                                            
                                            KFImage(URL(string: data!.userImageUrl))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                            
                                            
                                            Text(data!.username)
                                                .font(.system(size: 14))
                                                .padding(.trailing)
                                                .padding(.top, 20)
                                        }
                                    }
                                    .padding()
                                }
                            }
                            .padding(20)
                        }
                    )
            }
            .frame(height:200)
            .frame(maxWidth: .infinity)
        }
    }
}

//struct PostCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCellView(cellText: "hello")
//    }
//}
