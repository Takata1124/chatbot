//
//  HomeView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @State var showingSheet = false
    @State var showingSettingSheet = false
    @State var showingPostSheet = false
    @State var showingReviewSheet = false
    @State var showingDraftSheet = false
    
    @StateObject var dataModel = DataModel()
    @EnvironmentObject var movieViewModel: MovieViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {

        NavigationView {
            ZStack {
                Color.gray.opacity(0.3).ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 70){
                    
                    VStack {
                        KFImage(URL(string: authViewModel.userData!.ImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.black, lineWidth: 2))
                            .padding()
                        
                        Text("\(authViewModel.userData!.username)")
                            .font(.system(size: 18))
                    }

                    HStack(alignment: .center, spacing: 50) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(.bottom, 3)
                            Text("いいねされた数 100").font(.caption2)
                        }
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Image(systemName: "text.bubble")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(.bottom, 3)
                            Text("投稿数 100")
                                .font(.caption2)
                        }
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Image(systemName: "hand.thumbsup")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(.bottom, 3)
                            Text("いいねした数 100").font(.caption2)
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    
                    Button(action: {
                        movieViewModel.fetchEvaluateData(dataModel: dataModel)
                        self.showingSheet.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Label("送信", systemImage: "video")
                                .padding(.bottom, 3)
                            Text("ボット").font(.caption2)
                        }
                    }
                    Spacer()
                    Button(action: {
                        movieViewModel.fetchPostData(dataModel: dataModel, collectionName: "postArray")
                        self.showingPostSheet.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Label("送信", systemImage: "text.bubble")
                                .padding(.bottom, 3)
                            Text("投稿").font(.caption2)
                        }
                    }
                    Spacer()
                    Button(action: {
                        movieViewModel.fetchRealmReserveData(dataModel: dataModel)
                        self.showingDraftSheet.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Label("送信", systemImage: "paperclip")
                                .padding(.bottom, 3)
                            Text("下書き").font(.caption2)
                        }
                    }
                    Spacer()
                    Button(action: {
                        movieViewModel.fetchEvaluateData(dataModel: dataModel)
                        movieViewModel.deleteEvaluateData(dataModel: dataModel)
                        self.showingReviewSheet.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Label("送信", systemImage: "star")
                                .padding(.bottom, 3)
                            Text("履歴").font(.caption2)
                        }
                    }
                    Spacer()
                }
            }
            .accentColor(.black)
            .navigationBarTitle("HOME", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(Color.white)
            }), trailing: HStack {
                Button(action: {
                    self.showingSettingSheet.toggle()
                }, label: {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.white)
                })
            })
        }
        .onDisappear(perform: {
            
        })
        .fullScreenCover(isPresented: $showingSheet) {
            ContentView()
        }
        .fullScreenCover(isPresented: $showingSettingSheet) {
            SettingView()
        }
        .fullScreenCover(isPresented: $showingPostSheet) {
            PostView()
        }
        .fullScreenCover(isPresented: $showingReviewSheet) {
            ReviewView()
        }
        .fullScreenCover(isPresented: $showingDraftSheet) {
            DraftView()
        }
        .environmentObject(dataModel)
    }

    init() {
        self.setupNavigationBar()
        
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
