//
//  PostView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import SwiftUI

struct PostView: View {
    
    @State var text: String = ""
    @State private var showingAddPostSheet = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataModel: DataModel

//    let pokemons: [String] = ["Snorlax"]
    var postDataArray: [PostDataArray] = []
    
//    var filterdPokemons: [String] {
//        if text.isEmpty {
//            return pokemons
//        } else {
//            return pokemons.filter {$0.uppercased().contains(text.uppercased())}
//        }
//    }
    
    var body: some View {

        NavigationView {
            VStack {
                HStack {
                    TextField("Search Text here", text: $text)
                        .padding(20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        print("cancel")
                    } label: {
                        Text("cancel")
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                    
                }
                .background(Color.init(uiColor: .gray))
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    LazyVStack {
                        
                        ForEach(dataModel.postViewArray, id: \.self) { data in
                            
                            PostCellView(data: data)
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                                .onTapGesture {
                                    self.showingAddPostSheet.toggle()
                                }
                        }
                    }
                })
                    .navigationBarTitle("投稿", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        print("左のボタンが押されました。")
                        dismiss()
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .foregroundColor(Color.white)
                    }), trailing: HStack {
                        Button(action: {
                            print("右のボタン１が押されました。")
//                            self.showingAddPostSheet.toggle()
                        }, label: {
                            Image(systemName: "person")
//                            Text("下書き")
                                .foregroundColor(Color.white)
                        })
                    })
            }
        }
        .fullScreenCover(isPresented: $showingAddPostSheet) {
            AddPostView()
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

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
