//
//  ReviewView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/27.
//

import SwiftUI

struct ReviewView: View {
    
    @State var text: String = ""
    @State var categoryText: String = ""
    @State var yearText: String = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var movieViewModel = MovieViewModel()
    
    @EnvironmentObject var dataModel: DataModel
    
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
                    VStack {
                        TextField("Search Title", text: $text)
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Search Category", text: $categoryText)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Search Year", text: $yearText)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button {
                        self.text = ""
                        self.categoryText = ""
                        self.yearText = ""
                    } label: {
                        Text("CLEAR")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 30)
                }
                .background(Color.init(uiColor: .gray))
                
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
                                            let tempInt: Int = configureElement(movieArray: movie)
                                            if tempInt == i {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: 30))
                                                    .onTapGesture {
                                                        print(i)
                                                        print(movie.star)
                                                        print(movie.title)
                                                    }
                                            } else {
                                                Image(systemName: "star")
                                                    .font(.system(size: 30))
                                                    .onTapGesture {
                                                        print(i)
                                                        print(movie.star)
                                                        print(movie.title)
                                                        //
                                                        configureTitle(movieArray: movie, star: i)
                                                    }
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
                        }, label: {
                            Image(systemName: "star.fill")
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
    
    private func configureElement(movieArray: MovieArray) -> Int {
        
        let tempInt = 0
        for element in dataModel.tapArray {
            if element.title == movieArray.title {
                return element.star
            }
        }
        return tempInt
    }
    
    private func configureTitle(movieArray: MovieArray, star: Int) -> Void {
        
        let movie = movieArray
        
        var tempInt: Int = 0
        for element in dataModel.tapArray {
            if element.title == movie.title {
                dataModel.tapArray[tempInt].star = star
                return
            }
            
            tempInt += 1
        }
        
        dataModel.tapArray.append(TapArray(id: movie.number, title: movie.title, star: star))
        return
        
    }
}
//    struct ReviewView_Previews: PreviewProvider {
//        static var previews: some View {
//            ReviewView()
//        }
//    }
