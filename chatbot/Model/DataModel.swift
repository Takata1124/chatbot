//
//  Model.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import Foundation
import SwiftUI
import RealmSwift

class DataModel: ObservableObject {
    
    @Published var messages :[String] =  ["映画のおすすめを聞きますか？"]
    @Published var flowCount: Int = 0
    @Published var segueCount: Int = 0
    @Published var newYear: Bool = true
    @Published var tempTitle: String = ""
    @Published var tempCategory: String = ""
    @Published var tempYear: String = ""
    @Published var tempImageUrl: String = ""
    @Published var tempJenre: String = ""
    
    @Published var reloadInt: Int = 0
    @Published var totalInt: Int = 0
    
    @Published var cellnames: [CellName] = [
        CellName(name: "HOME"),
        CellName(name: "閉じる"),
    ]
    
    @Published var tapArray: [TapArray] = []
    @Published var postViewArray: [PostDataArray] = []
    @Published var reserveData: PostDataArray?
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

struct DecodeTapArray {
    
    let id: String
    let title: String
    let star: Int
    
    init(dic: [String: Any]) {
        self.id = dic["id"] as? String ?? ""
        self.title = dic["title"] as? String ?? ""
        self.star = dic["star"] as? Int ?? 0
    }
}

struct MovieArray: Hashable {
    
    let number: String
    let title: String
    let category: String
    let year: String
    let star: Int
}

struct PostDataArray:  Hashable{
    
    let title: String
    let category: String
    let year: String
    let star: Int
    let review: String
    let imageUrl: String
    let uid: String
    let username: String
    let userImageUrl: String
    let createdAt: Int
    
    init(dic: [String: Any]) {
        self.title = dic["title"] as? String ?? ""
        self.category = dic["category"] as? String ?? ""
        self.year = dic["year"] as? String ?? ""
        self.star = dic["star"] as? Int ?? 0
        self.review = dic["review"] as? String ?? ""
        self.imageUrl = dic["imageUrl"] as? String ?? ""
        self.uid = dic["uid"] as? String ?? ""
        self.username = dic["username"] as? String ?? ""
        self.userImageUrl = dic["userImageUrl"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Int ?? 0
    }
}

struct User {
    let username: String
    let email: String
    let ImageUrl: String
    
    init(dic: [String: Any]) {
        self.username = dic["username"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.ImageUrl = dic["ImageUrl"] as? String ?? ""
    }
}

class Reserve: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var title: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var star: Int = 0
    @objc dynamic var review: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var uid: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var userImageUrl: String = ""
    @objc dynamic var createdAt: Int = 0
}
