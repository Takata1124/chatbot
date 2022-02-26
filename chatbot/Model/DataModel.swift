//
//  Model.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import Foundation
import SwiftUI

class DataModel: ObservableObject {
    
    @Published var messages :[String] =  ["映画のおすすめを聞きますか？"]
    @Published var flowCount: Int = 0
    @Published var segueCount: Int = 0
    
    @Published var cellnames: [CellName] = [
        CellName(name: "HOME"),
        CellName(name: "閉じる"),
        CellName(name: "アクション"),
        CellName(name: "冒険"),
        CellName(name: "アニメーション"),
        CellName(name: "子供たち"),
        CellName(name: "コメディ"),
        CellName(name: "ファンタジー"),
        CellName(name: "ロマンス"),
        CellName(name: "ドラマ"),
        CellName(name: "犯罪"),
        CellName(name: "スリラー"),
        CellName(name: "ホラー"),
        CellName(name: "ミステリー"),
        CellName(name: "SF"),
    ]
    
}

struct CellName: Identifiable {
    
    let id = UUID()
    let name: String
}
