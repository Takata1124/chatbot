//
//  LoginView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.gray.opacity(0.3).ignoresSafeArea()

                VStack(alignment: .center) {
                    VStack(spacing: 40) {
                        
                        Spacer()
                        
                        TextField("Mail address", text: $inputEmail)
                            .padding()
                            .frame(width: 300, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                            .textInputAutocapitalization(.none)
                        
                        SecureField("Password", text: $inputPassword)
                            .padding()
                            .frame(width: 300, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                            .textInputAutocapitalization(.none)
                        
                        Button(action: {
                            print("Login処理")
                            authViewModel.login(mail: inputEmail, passward: inputPassword)
                        },
                               label: {
                            Text("Login")
                                .fontWeight(.medium)
                                .frame(minWidth: 160)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.accentColor)
                                .cornerRadius(8)
                        })
                        
                        Button(action: {
                            dismiss()
                        },
                               label: {
                            Text("新規アカウントの作成")
                                .fontWeight(.medium)
                                .frame(width: 300, height: 40)
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        })

                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Login",  displayMode: .inline)
        }
        .fullScreenCover(isPresented: $authViewModel.showingHomeSheet) {
            HomeView()
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

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
