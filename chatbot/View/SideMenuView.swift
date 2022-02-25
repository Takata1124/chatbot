//
//  SideMenuView.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import SwiftUI

struct SideMenuView: View {
    
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    
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

                MenuContent()
                    .frame(width: self.width)
                //                    .background(Color.gray)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}

fileprivate struct Pokemon: Identifiable {
    
    let id = UUID()
    let name: String
}

struct MenuContent: View {
    
    @State private var pokemons: [Pokemon] = [
        Pokemon(name: "映画bot"),
        Pokemon(name: "投稿"),
        Pokemon(name: "ヤドン")]
    
    let cellList = ["My Profile", "My Profile", "My Profile"]
    
    var body: some View {
        
        VStack {
            
            List(pokemons) { pokemon in
                Button(action: {
                    print(pokemon.id)
                }, label: {
                    Text(pokemon.name)
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