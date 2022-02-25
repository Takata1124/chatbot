//
//  String_Extension.swift
//  chatbot
//
//  Created by t032fj on 2022/02/25.
//

import Foundation

extension String {
    /// 頭文字は大文字、それ以外は小文字のStringを返す
    func initialUppercased() -> String {
        let lowercasedString = self.lowercased()
        return lowercasedString.prefix(1).uppercased() + lowercasedString.dropFirst()
    }
}
