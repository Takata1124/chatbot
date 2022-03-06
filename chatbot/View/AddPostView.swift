//
//  AddPostView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/26.
//

import SwiftUI

struct AddPostView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var text: String = ""

    var body: some View {
        
        NavigationView {
            
            VStack {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.pink.opacity(0.8))
                        .overlay(
                            VStack (spacing: 50) {
                                
                                HStack (spacing: 20) {
                                    Image(systemName: "person")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    Text("takatatakata")
                                        .font(.system(size: 24))
                                    
                                    Spacer()
                                }
                                .padding(.leading, 30)
                                
                                VStack {
                                    Text("レビュータイトル")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)
    
                                }
                               
                                VStack {
                                    Text("レビュー")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)
                                    
                                    TextField("", text: $text)
                                        .frame(width: 300,height: 200)
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .padding(12)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                }
                                
                                HStack {
                                    ForEach(0..<5) { i in
                                        Image(systemName: "star")
                                            .font(.system(size: 26))
                                    }
                                }
                                
                                Button {
                                    print("tap")
                                } label: {
                                    Text("投稿")
                                }
                                .frame(width: 300)
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .padding(12)
                                .background(Color.gray.opacity(0.9))
                                .cornerRadius(20)
                            }
                        )
                }
                
                .padding()
                
            }
            .navigationBarTitle("レビュー投稿", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("左のボタンが押されました。")
                dismiss()
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(Color.white)
            }), trailing: HStack {
            })
        }
    }
    
    init() {
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView()
    }
}
