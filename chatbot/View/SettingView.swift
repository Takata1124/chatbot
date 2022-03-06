//
//  SettingView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct SettingView: View {
    
    @State  private var isOn = false
    @State  var pickerSelection = 0
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var movieViewModel = MovieViewModel()
    
    let languages: [String] = [
        "English",
        "Japanease",
    ]
    
    var body: some View {
        
        NavigationView {
            Form {
                HStack {
                    Image(systemName: "person.circle")
                    Button("Sign in to your iPhone", action: {})
                        .foregroundColor(Color.black)
                }
                
                Section(header: Text("General")) {
                    HStack {
                        Text("Airplane Mode")
                        Spacer()
                        Toggle(isOn: $isOn) {
                            EmptyView()
                        }
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("Language")) {
                            ForEach(0..<self.languages.count) { index in
                                Text(self.languages[index])
                            }
                        }
                    }
                }
                
                Section(header: Text("About"), footer: Text("copyright ©︎ 20XX-20XX Apple All Rights Reserved.")) {
                    HStack {
                        Text("Device Name")
                        Spacer()
                        Text(UIDevice.current.name)
                    }
                    HStack {
                        Text("Operating System")
                        Spacer()
                        Text(UIDevice.current.systemName)
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(UIDevice.current.systemVersion)
                    }
                }
                
                Section(header: Text("LogOut")) {
                    HStack {
                        Text("LOGOUT")
                            .onTapGesture {
                                print("Logout")
                                authViewModel.signout()
                            }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("タイトル", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("左のボタンが押されました。")
                dismiss()
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(Color.white)
            }), trailing: HStack {
                Button(action: {
                    print("右のボタン１が押されました。")
//                    self.authViewModel.signout()
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color.white)
                })
            })
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
