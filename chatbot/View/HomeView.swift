//
//  HomeView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var showingSheet = false
    @State var showingSettingSheet = false
    @State var showingPostSheet = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.gray.opacity(0.3).ignoresSafeArea()
//
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action: {
                        self.showingSheet.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Label("送信", systemImage: "video")
                                .padding(.bottom, 3)
                            Text("映画bot").font(.caption2)
                        }
                    }
                    Spacer()
                    Button(action: {
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
                        self.showingSettingSheet.toggle()
                    }) {
                        VStack(alignment: .center) {
                            Label("送信", systemImage: "gearshape")
                                .padding(.bottom, 3)
                            Text("設定").font(.caption2)
                        }
                    }
                    Spacer()
                }
            }
            .accentColor(.black)
//            .background(Color.gray.opacity(0.3))
            .navigationBarTitle("HOME", displayMode: .inline)
        }
        .fullScreenCover(isPresented: $showingSheet) {
            ContentView()
        }
        .fullScreenCover(isPresented: $showingSettingSheet) {
            SettingView()
        }
        .fullScreenCover(isPresented: $showingPostSheet) {
            PostView()
        }
    }
    
    init() {
        self.setupNavigationBar()
        
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
