//
//  PostView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import SwiftUI

struct PostView: View {
    
    @State var text: String = ""
    let pokemons: [String] = ["Snorlax", "Slowpoke", "Pikachu", "Eevee"]
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                TextField("", text: $text)
                    .padding(15)
                    .background(Color.init(uiColor: .gray))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    LazyVStack {
                        
                        ForEach(pokemons, id: \.self) { pokemon in
                            
                            PostCellView(cellText: pokemon)
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                        }
                    }
                })
                .navigationBarTitle("レビュー", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("左のボタンが押されました。")
                }, label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(Color.white)
                }), trailing: HStack {
                    Button(action: {
                        print("右のボタン１が押されました。")
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                    })
                })
            }
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

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
