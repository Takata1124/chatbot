//
//  MovieViewModel.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import Foundation
import SwiftGoogleTranslate

class MovieViewModel: NSObject, ObservableObject {
    
    let datamodel = DataModel()
    var apiKey: String = "apikey"
    
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
        print(csvArray.count)
        
        for csv in csvArray {
            if csv == "" {
                
            } else {
                tempcsv.append(csv)
            }
        }
        
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
    
    func getBotResponse(message: String) -> String {
        
        print(datamodel.flowCount)
        
        let nowCount = datamodel.flowCount
        let tempMessage = message.lowercased()
        
        switch nowCount {
            
        case 0:
            
            let returnMessage = firstSession(tempMessage: tempMessage)
            return returnMessage
        case 1:
           
            return "count1"
            
        default:
           
            return "example"
        }
    }
    
    func firstSession(tempMessage: String) -> String{
        
        if tempMessage.contains("はい") {
            datamodel.flowCount += 1
            return "見たい映画のジャンルを教えてください/rロマンス/rロマンス"
        } else if tempMessage.contains("いいえ") {
            datamodel.flowCount -= 1
            return "またよろしくお願いします"
        } else {
            datamodel.flowCount += 1
            return "That's cool."
        }
    }
    
    
    private func enTranslate() {
        
        SwiftGoogleTranslate.shared.start(with: apiKey)
        
        SwiftGoogleTranslate.shared.translate("Hello!", "es", "en") { (text, error) in
          if let t = text {
            print(t)
          }
        }
    }
    
    
}
