//
//  ContentView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var dataModel: DataModel
    @ObservedObject var movieViewModel = MovieViewModel()
    
    @State private var messageText = ""
    @State var showingDetailSheet: Bool = false
    @State var menuOpen: Bool = false
    @State var reloadTimes: Int = 0
    @State var isLoading: Bool = false
    
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
                    
                    ChatCellView(dataModel: dataModel, movieViewModel: movieViewModel, isLoading: $isLoading, showingDetailSheet: $showingDetailSheet)
                }
                .navigationBarTitle("タイトル", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
//                    self.openMenu()
                    dismiss()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .foregroundColor(Color.white)
                }), trailing: HStack {
                    Button(action: {
                        dataModel.messages = ["映画のおすすめを聞きますか？"]
                        dataModel.flowCount = 0
                    }, label: {
                        Text("CLEAR")
                            .foregroundColor(Color.white)
                    })
                })
                
                if isLoading {
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .red))
                        .scaleEffect(3)
                }
               
//                SideMenuView(width: 270, isOpen: $menuOpen, dataModel: dataModel, menuClose: self.openMenu, function: self.passedFunction)
            }
        }
        .fullScreenCover(isPresented: $showingDetailSheet) {
            AddPostView()
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
