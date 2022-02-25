//
//  MovieViewModel.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import Foundation
import SwiftGoogleTranslate

class MovieViewModel: NSObject, ObservableObject {
    
    var apiKey: String = Apikey().apikey
    
    func loadCSV(fileName: String) -> [String] {
        
        var csvArray: [String] = []
        var tempcsv: [String] = []
        
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        
        for csv in csvArray {
            if csv == "" {
                
            } else {
                tempcsv.append(csv)
            }
        }
        print(tempcsv)
        return tempcsv
    }
    
    func filterCSV(array: [String], year: String?, genre: String?) -> [String] {
        
        var filterArray:[String] = []
        
        if year != nil {
            filterArray = array.filter {$0.contains(year!)}
        }
        if genre != nil {
            filterArray = array.filter {$0.contains(genre!)}
        }
        
        return filterArray
    }
    
    func getBotResponse(message: String, nowCount: Int) -> String {
        
        let tempMessage = message.lowercased()
        
        switch nowCount {
            
        case 1:
            let returnMessage = firstSession(tempMessage: tempMessage)
            return returnMessage
        case 2:
            return "count1"
        default:
            return "またよろしくお願いします"
        }
    }
    
    func firstSession(tempMessage: String) -> String{
        
        if tempMessage.contains("はい") {
            
            return "見たい映画のジャンルを教えてください(アクション/冒険/アニメーション/子供たち/コメディ/ファンタジー/ロマンス/ドラマ/犯罪/スリラー/ホラー/ミステリー/SF)"
        } else {
            
            return "またよろしくお願いします"
        }
    }

    func enTranslate(translatingText: String) -> Void {
        
        SwiftGoogleTranslate.shared.start(with: apiKey)
        SwiftGoogleTranslate.shared.translate(translatingText, "en", "ja") { (text, error) in
            if let t = text {
                print(t)
//                print(t.initialUppercased())
                self.analyzeText(text: t)

                return
            }
        }
    }
    
    func analyzeText(text: String) {
        
        var separetedArray: [String] = []

        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: 0)
        
        tagger.string = text
        tagger.enumerateTags(in: NSRange(location: 0, length: text.count), scheme: NSLinguisticTagScheme.lexicalClass, options: [.omitWhitespace]) { tag, tokenRange, sentenceRange, stop in
            
            let subString = (text as NSString).substring(with: tokenRange)
            
            guard let tag = tag else { return }
//            guard let subString = subString else { return }
   
//            print(tag.rawValue)
//            print(subString)
            
            if tag.rawValue == "Noun" {
                separetedArray.append(subString)
            }
//            print("\(subString) : \(String(describing: tag))")
        }
        print(separetedArray)
        if separetedArray != [] {
            print(separetedArray[0].initialUppercased())
        }
    }
}

