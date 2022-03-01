//
//  MovieViewModel.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import Foundation
import SwiftGoogleTranslate
import SwiftUI

struct MovieArray: Hashable {
    
    var number: String
    var title: String
    var category: String
    var year: String
}

class MovieViewModel: NSObject, ObservableObject {
    
    var apiKey: String = Apikey().apikey
    var movieArray: [String] = []
    var movieCateArray: [MovieArray] = []
//    var splitedYearArray: [String] = ["???,(???),???"]

    override init() {
        super.init()
        
        let array = loadCSV(fileName: "movies")
        self.movieArray = array
        
        var number: String = "0"
        var title: String = "???"
        var category: String = "???"
        var year: String = "???"
        
        for i in  1..<self.movieArray.count {
            let splitedArray: [String] = array[i].components(separatedBy: ",")
            
            number = splitedArray.first ?? "???"
            title = splitedArray[1]
            category = splitedArray.last ?? "???"
            
            if array[i].contains(")") {
                var splitedYearArray: [String] = array[i].components(separatedBy: ",")
                splitedYearArray.removeLast()
                let tempYear = splitedYearArray.last?.components(separatedBy: "(")
                let newYear = tempYear?.last?.components(separatedBy: ")")
                year = (newYear?[0])!
                
                let tempTitle = title.components(separatedBy: "(")
                title = tempTitle[0]
                
                if  array[i].components(separatedBy: "(").count > 2 {
                    var splitedArray = array[i].components(separatedBy: ")")
                    splitedArray = splitedArray[0].components(separatedBy: ",")
                    title = splitedArray[1]
                }
                
                
            }

            movieCateArray.append(
                MovieArray(number: number, title: title, category: category, year: year))
        }
    }

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
            
            let returnMessage = secondSession(tempMessage: tempMessage)
            let filterArray = filterCSV(array: movieArray, year: returnMessage, genre: nil)
            
            if filterArray == [] {
                return "他の言葉で言いかえてください"
            }

            print(filterArray[0])
//            print(filterArray.count)
            let splitedArray: [String] = filterArray[0].components(separatedBy: ",")
            let translatedText: String = japaneseTranselate(translatingText: splitedArray[1])

            return translatedText

        default:
            return "またよろしくお願いします"
        }
    }
    
    private func firstSession(tempMessage: String) -> String {
        
        if tempMessage.contains("はい") {
            
            return "見たい映画のジャンルを教えてください(アクション/冒険/アニメーション/子供たち/コメディ/ファンタジー/ロマンス/ドラマ/犯罪/スリラー/ホラー/ミステリー/SF)"
        } else {
            
            return "またよろしくお願いします"
        }
    }
    private func secondSession(tempMessage: String) -> String {
        
        let text = englishTranslate(translatingText: tempMessage)
        
        return text
    }
    
    func japaneseTranselate(translatingText: String) -> String {
        
        var tempText: String = "nil"
        
        SwiftGoogleTranslate.shared.start(with: apiKey)
        SwiftGoogleTranslate.shared.translate(translatingText, "ja", "en") { (text, error) in
            
            if error != nil {
                fatalError("error")
            }
            if let t = text {
                print(t)
                //                print(t)
                //                print(t.initialUppercased())
                tempText = t
            }
        }
        //APIの処理時間
        sleep(1)
        return tempText
        
    }

    func englishTranslate(translatingText: String) -> String {
        
        var tempText: String = "nil"
        
        SwiftGoogleTranslate.shared.start(with: apiKey)
        SwiftGoogleTranslate.shared.translate(translatingText, "en", "ja") { (text, error) in
            
            if error != nil {
                fatalError("error")
            }
            if let t = text {
                print(t)
                //                print(t)
                //                print(t.initialUppercased())
                tempText = self.analyzeText(text: t)
            }
        }
        //APIの処理時間
        sleep(1)
        return tempText
    }
    
    func analyzeText(text: String) -> String {
        
        var separetedArray: [String] = []
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: 0)
        
        tagger.string = text
        tagger.enumerateTags(in: NSRange(location: 0, length: text.count), scheme: NSLinguisticTagScheme.lexicalClass, options: [.omitWhitespace]) { tag, tokenRange, sentenceRange, stop in
            
            let subString = (text as NSString).substring(with: tokenRange)
            
            guard let tag = tag else { return }
            
            if tag.rawValue == "Noun" {
                separetedArray.append(subString)
            }
            
        }
        print(separetedArray)
        
        if separetedArray != [] {
           print(separetedArray[0].initialUppercased())
            return separetedArray[0].initialUppercased()
        } else {
            let void: String = "void"
            return void
        }
    }
}

