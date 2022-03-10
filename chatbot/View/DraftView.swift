//
//  DraftView.swift
//  chatbot
//
//  Created by t032fj on 2022/03/10.
//

import SwiftUI
import Kingfisher

struct DraftView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var movieViewModel: MovieViewModel
    @EnvironmentObject var dataModel: DataModel
    @State var text: String = ""
    @State var star: Int = 0
    
    var enable: Bool {
        
        if text.isEmpty {
            return false
        }
        if star == 0 {
            return false
        }
        return true
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.pink.opacity(0.8))
                        .overlay(
                            VStack (spacing: 50) {
                                VStack (spacing: 20) {

                                    Text("タイトル：\(dataModel.reserveData!.title)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)

                                    Text("カテゴリ：\(dataModel.reserveData!.category)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)

                                    KFImage(URL(string: dataModel.reserveData!.imageUrl))
                                        .resizable()
                                        .frame(width: 200, height: 278)

                                    MultilineTextView(text: $text)
                                        .frame(width: 200, height: 100)
                                        .border(Color.gray)
                                }
                                
                                HStack {
                                    ForEach(1..<6) { i in
                                        VStack(alignment: .center) {
                                            Text("\(i)")
                                            if i == self.star {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: 26))
                                                    .onTapGesture {
                                                        self.star = i
                                                    }
                                            } else {
                                                Image(systemName: "star")
                                                    .font(.system(size: 26))
                                                    .onTapGesture {
                                                        self.star = i
                                                    }
                                            }
                                        }
                                    }
                                }
                                
                                Button {
//                                    movieViewModel.savePostData(dataModel: dataModel, authViewModel: authViewModel, star: star, review: text, collectionName: "postArray")
                                        dismiss()
                                } label: {
                                    Text("投稿")
                                }
                                .frame(width: 100)
                                .foregroundColor(.black)
                                .padding(12)
                                .background(enable ? Color.blue : Color.gray)
                                .cornerRadius(20)
                                .disabled(!enable)
                            }
                        )
                }
                .padding()
            }
            .navigationBarTitle("投稿", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(Color.white)
            }), trailing: HStack {
            })
        }
        .environmentObject(movieViewModel)
        .environmentObject(dataModel)
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

//struct DraftView_Previews: PreviewProvider {
//    static var previews: some View {
//        DraftView()
//    }
//}
