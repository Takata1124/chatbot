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
                        
                        ForEach(dataModel.messages, id: \.self) { message in
                            if message.contains("[USER]") {
                                let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                                
                                SelfCellView(message: newMessage)

                            } else {
                                
                               BotCellView(message: message)
                            }
                            
                        }.rotationEffect(.degrees(180))
                    }
                    .rotationEffect(.degrees(180))
                    .background(Color.gray.opacity(0.1))
                    
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel)
                    
                }
                .navigationBarTitle("タイトル", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    
                    self.openMenu()
                }, label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(Color.white)
                }), trailing: HStack {
                    Button(action: {
                        
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

//extension String {
//
//    /// 頭文字は大文字、それ以外は小文字のStringを返す
//    func initialUppercased() -> String {
//        let lowercasedString = self.lowercased()
//        return lowercasedString.prefix(1).uppercased() + lowercasedString.dropFirst()
//    }
//}

//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//        }
//    }
