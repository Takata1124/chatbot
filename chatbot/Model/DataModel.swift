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
}

struct Pokemon: Identifiable {
    
    let id = UUID()
    let name: String
}
