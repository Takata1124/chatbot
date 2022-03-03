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
    ]
    
    @Published var tapArray: [TapArray] = []
}

struct CellName: Identifiable {
    
    let id = UUID()
    let name: String
}

struct TapArray: Identifiable, Equatable {
    
    var id: String
    let title: String
    var star: Int
}

struct MovieArray: Hashable {
    
    var number: String
    var title: String
    var category: String
    var year: String
    var star: Int
}
