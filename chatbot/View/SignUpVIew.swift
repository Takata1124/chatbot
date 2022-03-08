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
    
    @State var errorMessage: String = "入力を完了してください"
    @State var showingPicker = false
    @State var showingLoginsheet = false
    @State var image: UIImage?
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var enable: Bool {
        
        if username.isEmpty || inputEmail.isEmpty || inputPassword.isEmpty {
            return false
        }
        
        if inputPassword.count < 6 {
            DispatchQueue.main.async {
                self.errorMessage = "パスワードは6文字以上でお願いします"
            }
            return false
        }
        
        if image == nil {
            
            DispatchQueue.main.async {
                self.errorMessage = "アイコンをタッチしImageを設定してください"
            }
            return false
        }
        
        else {
            return true
        }
    }

    var body: some View {

        NavigationView {
            
            ZStack {
                Color.gray.opacity(0.3).ignoresSafeArea()
                
                VStack(alignment: .center) {
                    
                    VStack(spacing: 30) {

                        Spacer()
                        
                        Image(uiImage: (image ?? UIImage(named: "default.png"))!)
                            .resizable()
                            .scaledToFill()
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
                            .textInputAutocapitalization(.none)
                        
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
                        
                        Text("\(errorMessage)")
                            .font(.system(size: 16))
                        
                        Button(action:
                                
                            { guard let image = image else { return }
                            authViewModel.register(username: username, mail: inputEmail, passward: inputPassword, uiImage: image)
                        },
                               label: {
                            Text("SignUp")
                                .fontWeight(.medium)
                                .frame(minWidth: 160)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(enable ? Color.blue : Color.gray)
                                .cornerRadius(8)
                        })
                            .disabled(!enable)
                        
                        Button(action: {
                            self.showingLoginsheet.toggle()
                        },
                               label: {
                            Text("既にアカウントをお持ちの方はこちら")
                                .fontWeight(.medium)
                                .frame(width: 300, height: 40)
                                .foregroundColor(Color.blue)
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
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

//struct SignUpVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpVIew()
//    }
//}
