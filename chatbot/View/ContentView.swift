//
//  ContentView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dataModel = DataModel()
    @ObservedObject var movieViewModel = MovieViewModel()
    
    @Environment(\.isPresented) var isPresented
    
    @State private var messageText = ""
    @State private var showingSheet = false
    @State var menuOpen: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                VStack {
                    ScrollView {
                        
                        ForEach(self.dataModel.messages, id: \.self) { message in
                            if message.contains("[USER]") {
                                let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                                
                                HStack {
                                    Spacer()
                                    Text(newMessage)
                                        .padding()
                                        .foregroundColor(Color.white)
                                        .background(Color.blue.opacity(0.8))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                }
                            } else {
                                HStack {
                                    Text(message)
                                        .padding()
                                        .background(Color.gray.opacity(0.15))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                    Spacer()
                                }
                            }
                            
                        }.rotationEffect(.degrees(180))
                    }
                    .rotationEffect(.degrees(180))
                    .background(Color.gray.opacity(0.1))
                    
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel)
                    
                }
                .navigationBarTitle("タイトル", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    print("左のボタンが押されました。")
                    self.openMenu()
                }, label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(Color.white)
                }), trailing: HStack {
                    Button(action: {
                        print("右のボタン１が押されました。")
                        self.showingSheet.toggle()
                    }, label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(Color.white)
                    })
                })
                SideMenuView(width: 270,isOpen: self.menuOpen, menuClose: self.openMenu)
            }
            
        }
        .fullScreenCover(isPresented: $showingSheet) {
            SettingView()
        }
    }
    
    private func openMenu() {
        self.menuOpen.toggle()
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

//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//        }
//    }
