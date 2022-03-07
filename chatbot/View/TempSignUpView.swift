//
//  TempSignUpView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct TempSignUpView: View {
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.gray.opacity(0.3).ignoresSafeArea()

                VStack(alignment: .center) {
                    
                    VStack(spacing: 40) {
                        
                        Spacer()
                        
                        Button(action: {
                            
                        },
                               label: {
                            Text("LogIn")
                                .fontWeight(.medium)
                                .frame(minWidth: 160)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.accentColor)
                                .cornerRadius(8)
                        })
                        
                        Button(action: {
//                            self.showingLoginsheet.toggle()
                        },
                               label: {
                            Text("アカウント登録をやめます")
                                .fontWeight(.medium)
                                .frame(width: 300, height: 40)
                                .foregroundColor(.blue)
                                .padding(12)
                                .cornerRadius(8)
                        })
                        
                        Spacer()
                    }
                }
            }
//            .fullScreenCover(isPresented: $showingLoginsheet) {
//                LoginView()
//            }
            .navigationBarTitle("SignUp",  displayMode: .inline)
        }
    }
    
    init() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 30)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

//struct TempSignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        TempSignUpView()
//    }
//}
