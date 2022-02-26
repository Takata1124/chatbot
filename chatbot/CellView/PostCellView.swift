//
//  PostCellView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/26.
//

import SwiftUI

struct PostCellView: View {
    
    var cellText: String
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.pink.opacity(0.8))
                    .overlay(
                        
                        HStack {
                            VStack {
                                HStack {
                                    Text(cellText)
                                        .foregroundColor(.black)
                                        .font(.system(size: 26))
                                        .font(.largeTitle)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "heart")
                                        .font(.system(size: 26))
                                        .padding(.trailing)
                                }
                                
                                Text("hellohellohellohellohellohellohello")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 3)
                                
                                HStack {
                                    
                                    Image(systemName: "person")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    Text("Takata")
                                        .padding(.top, 20)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        ForEach(0..<4) { i in
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 26))
                                        }
                                    }
                                    .padding(.trailing)
                                    
                                }
                                .padding(.top, 15)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                        }
                    )
            }
            .frame(height:200)
            .frame(maxWidth: .infinity)
        }
    }
}

struct PostCellView_Previews: PreviewProvider {
    static var previews: some View {
        PostCellView(cellText: "hello")
    }
}
