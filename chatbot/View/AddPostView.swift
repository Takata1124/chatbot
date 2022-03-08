//
//  AddPostView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/26.
//

import SwiftUI
import Kingfisher
import Combine

struct AddPostView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var movieViewModel: MovieViewModel
    @EnvironmentObject var dataModel: DataModel
    @State var text: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.pink.opacity(0.8))
                        .overlay(
                            VStack (spacing: 50) {
                                
                                VStack (spacing: 30) {
                                    
                                    Text("タイトル：\(dataModel.tempTitle)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)
                                    
                                    Text("カテゴリ：\(dataModel.tempCategory)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 35)
                                    
                                    KFImage(URL(string:dataModel.tempImageUrl))
                                        .resizable()
//                                        .scaledToFill()
                                        .frame(width: 165, height: 230)
                                    
                                    MultilineTextView(text: $text)
//                                        .padding()
                                        .frame(width: 200, height: 100)
                                        .border(Color.gray)
                                    
                                }
                                
                                HStack {
                                    ForEach(1..<6) { i in
                                        VStack(alignment: .center) {
                                            Text("\(i)")
                                            Image(systemName: "star")
                                                .font(.system(size: 26))
                                        }
                                    }
                                }
                                
                                Button {
                                    print("tap")
                                } label: {
                                    Text("投稿")
                                }
                                .frame(width: 100)
                                //                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .padding(12)
                                .background(Color.gray.opacity(0.9))
                                .cornerRadius(20)
                                
                            }
                        )
                }
                .padding()
                
            }
            .navigationBarTitle("投稿", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("左のボタンが押されました。")
                dismiss()
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(Color.white)
            }), trailing: HStack {
                Text("下書き保存")
                    .foregroundColor(Color.white)
            })
        }
        .environmentObject(movieViewModel)
        .environmentObject(dataModel)
        .environmentObject(authViewModel)
    }
    
    init() {
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

//struct AddPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPostView()
//            .environmentObject(MovieViewModel())
//            .environmentObject(DataModel())
//            .environmentObject(AuthViewModel())
//    }
//}

struct MultilineTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    final class Coordinator: NSObject, UITextViewDelegate {
        private var textView: MultilineTextView
        
        init(_ textView: MultilineTextView) {
            self.textView = textView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.textView.text = textView.text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
