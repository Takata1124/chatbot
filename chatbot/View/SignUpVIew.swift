//
//  SignUpVIew.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct SignUpVIew: View {
    
    @State var username: String = ""
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    
    @State var showingPicker = false
    @State var showingLoginsheet = false
    @State var image: UIImage?
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.gray.opacity(0.3).ignoresSafeArea()

                VStack(alignment: .center) {
                    
                    VStack(spacing: 40) {
                        
                        Text("")
                        
                        Image(uiImage: (image ?? UIImage(named: "default.png"))!)
                            .resizable()
                            .scaledToFill()
                        //                            .padding()
                            .frame(width: 200, height: 200, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.black, lineWidth: 2))
                            .onTapGesture {
                                showingPicker.toggle()
                            }
                        
                        TextField("username", text: $username)
                            .padding()
                            .frame(width: 300, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        TextField("Mail address", text: $inputEmail)
                            .padding()
                            .frame(width: 300, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        SecureField("Password", text: $inputPassword)
                            .padding()
                            .frame(width: 300, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        Button(action: {
                            
                        },
                               label: {
                            Text("SignUp")
                                .fontWeight(.medium)
                                .frame(minWidth: 160)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.accentColor)
                                .cornerRadius(8)
                        })
                        
                        Button(action: {
                            self.showingLoginsheet.toggle()
                        },
                               label: {
                            Text("既にアカウントをお持ちの方はこちら")
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
            .sheet(isPresented: $showingPicker) {
                ImagePickerView(image: $image, sourceType: .library)
            }
            .fullScreenCover(isPresented: $showingLoginsheet) {
                LoginView()
            }
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
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

//struct SignUpVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpVIew()
//    }
//}
