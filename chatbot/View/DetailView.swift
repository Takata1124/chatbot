//
//  DetailView.swift
//  chatbot
//
//  Created by t032fj on 2022/03/09.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var title: String = ""
    var category: String = ""
    var text: String = ""
    var imageUrl: String = ""
    var star: Int = 0
    
    init(title: String, category: String, text: String, imageUrl: String, star: Int) {
        self.title = title
        self.category = category
        self.text = text
        self.imageUrl = imageUrl
        self.star = star
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.pink.opacity(0.8))
                        .overlay(
                            VStack (spacing: 50) {
                                VStack (spacing: 30) {
                                    Text("タイトル：\(title)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)
                                    
                                    Text("カテゴリ：\(category)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)
                                    
                                    KFImage(URL(string: imageUrl))
                                        .resizable()
                                        .frame(width: 165, height: 230)
                                    
                                    Text(text)
                                        .frame(width: 200, height: 100)
                                        .border(Color.gray)
                                }
                                
                                HStack {
                                    ForEach(0..<star) { i in
                                        VStack(alignment: .center) {
                                            Text("\(i)")
                                            Image(systemName: "star")
                                                .font(.system(size: 26))
                                        }
                                    }
                                }
                                
                                Button {
                                    print("tap")
                                } label: {
                                    Text("投稿")
                                }
                                .frame(width: 100)
                                .foregroundColor(.black)
                                .padding(12)
                                .background(Color.gray.opacity(0.9))
                                .cornerRadius(20)
                            }
                        )
                }
                .padding()
                
            }
            .navigationBarTitle("投稿", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("左のボタンが押されました。")
                dismiss()
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(Color.white)
            }), trailing: HStack {
                Text("下書き保存")
                    .foregroundColor(Color.white)
            })
        }
//        .environmentObject(movieViewModel)
//        .environmentObject(dataModel)
//        .environmentObject(authViewModel)
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

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
