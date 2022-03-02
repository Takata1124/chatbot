//
//  ReviewView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/27.
//

import SwiftUI

struct ReviewView: View {
    
    let pokemons: [String] = ["Snorlax", "Slowpoke", "Pikachu", "Eevee"]
    @State var text: String = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var movieViewModel = MovieViewModel()
    @State private var currentValue: Double = 5
    
    var filterdMovieArray: [MovieArray] {
        if text.isEmpty {
            return movieViewModel.movieCateArray
        } else {
            return movieViewModel.movieCateArray.filter {$0.title.uppercased().contains(text.uppercased())}
        }
    }
    
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
                
                HStack {
                    Text("値：\(currentValue)")
                    Slider(value: $currentValue, in: 0...10)      // 0から10の範囲を指定
                }
                .padding()
//                .background(Color.init(uiColor: .gray))
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    LazyVStack {
                        ForEach(filterdMovieArray, id: \.self) { movie in
                            VStack(alignment: .leading, spacing: 10){
                                HStack {
                                    Text("\(movie.title)")
                                        .font(.system(size: 18))
                                    Spacer()
                                    Text("\(movie.year)")
                                        .padding(.trailing)
                                }
                                Text("\(movie.category)")
                                HStack {
                                    ForEach(1..<6) { i in
                                        VStack(alignment: .center){
                                            Text("\(i)")
                                            Image(systemName: "star")
                                                .font(.system(size: 30))
                                                .onTapGesture {
                                                    print(i)
                                                    print(movie.title)
                                                }
                                        }
                                    }
                                }
                                .padding(.trailing)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .frame(height: 150)
                            .background(Color.gray.opacity(0.5))
                            .padding(.horizontal, 10)
                        }
                    }
                })
                    .navigationBarTitle("投稿一覧", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        print("左のボタンが押されました。")
                        dismiss()
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .foregroundColor(Color.white)
                    }), trailing: HStack {
                        Button(action: {
                            print("右のボタン１が押されました。")
                            print(movieViewModel.movieCateArray.count)
                            print(movieViewModel.movieCateArray[1])
                            //                            self.showingAddPostSheet.toggle()
                        }, label: {
                            //                            Image(systemName: "person")
                            //                                .foregroundColor(Color.white)
                            Text("SAVE")
                                .foregroundColor(Color.white)
                        })
                    })
            }
        }
        //        .fullScreenCover(isPresented: $showingAddPostSheet) {
        //            AddPostView()
        //        }
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

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
