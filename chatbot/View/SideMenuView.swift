//
//  SideMenuView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct SideMenuView: View {
    
    let width: CGFloat
    @Binding var isOpen: Bool
    let menuClose: () -> Void
    
    var function: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            }
            
            HStack {

                MenuContent(isOpen: self.$isOpen, function: function)
                    .frame(width: self.width)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}

struct MenuContent: View {
    
    @Binding var isOpen: Bool
    var function: () -> Void
    
    @State private var cellnames: [CellName] = [
        CellName(name: "HOME"),
        CellName(name: "映画bot"),
        CellName(name: "レビュー投稿"),
        CellName(name: "閉じる")]
    
    
    var body: some View {
        
        VStack {
            List(cellnames) { cellname in
                Button(action: {
                    print(cellname.name)
                    
                    if cellname.name == "閉じる" {
                        self.isOpen.toggle()
                    } else if cellname.name == "HOME" {
                        self.isOpen.toggle()
                        self.function()
                    }
                    
                }, label: {
                    Text(cellname.name)
                })
            }
            .listStyle(InsetListStyle())
        }
        .environment(\.defaultMinListRowHeight, 70)
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView()
//    }
//}
