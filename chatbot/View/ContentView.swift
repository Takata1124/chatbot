//
//  ContentView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var dataModel = DataModel()
    @ObservedObject var movieViewModel = MovieViewModel()
    
    @State private var messageText = ""
    @State private var showingSettingSheet = false
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
                    .background(Color.gray.opacity(0.2))
                    
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
                        
                        self.showingSettingSheet.toggle()
                    }, label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(Color.white)
                    })
                })
                
                SideMenuView(width: 270, isOpen: $menuOpen, menuClose: self.openMenu, function: self.passedFunction)
            }
        }
        .fullScreenCover(isPresented: $showingSettingSheet) {
            SettingView()
        }
    }
    
    private func passedFunction() {
        dismiss()
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
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
