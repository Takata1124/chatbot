//
//  Model.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import Foundation

class DataModel: ObservableObject {
    
    @Published var messages :[String] =  ["映画のおすすめを聞きますか？"]
    @Published var flowCount: Int = 0
    @Published var segueCount: Int = 0
}

struct CellName: Identifiable {
    
    let id = UUID()
    let name: String
}
