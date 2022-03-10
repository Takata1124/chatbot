//
//  SettingView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI
import Kingfisher

struct SettingView: View {
    
    @State  private var isOn = false
    @State  var pickerSelection = 0
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var movieViewModel = MovieViewModel()
    
    var body: some View {
        
        NavigationView {
            Form {
                HStack (spacing: 20){
                    KFImage(URL(string: authViewModel.userData!.ImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
//                        .overlay(Circle()
//                                    .stroke(Color.black, lineWidth: 1))
                        
                    Text("\(authViewModel.userData!.username)")
                        .foregroundColor(Color.black)
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
            .navigationBarTitle("設定", displayMode: .inline)
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
