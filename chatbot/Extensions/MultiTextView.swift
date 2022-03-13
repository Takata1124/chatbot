//
//  MultiTextView.swift
//  chatbot
//
//  Created by t032fj on 2022/03/09.
//

//import Foundation
//import SwiftUI
//
//struct MultilineTextView: UIViewRepresentable {
//    
//    @Binding var text: String
//    
//    final class Coordinator: NSObject, UITextViewDelegate {
//        private var textView: MultilineTextView
//        
//        init(_ textView: MultilineTextView) {
//            self.textView = textView
//        }
//        
//        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//            return true
//        }
//        
//        func textViewDidChange(_ textView: UITextView) {
//            self.textView.text = textView.text
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.delegate = context.coordinator
//        textView.isScrollEnabled = true
//        textView.isEditable = true
//        textView.isUserInteractionEnabled = true
//        return textView
//    }
//    
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.text = text
//    }
//}
//
