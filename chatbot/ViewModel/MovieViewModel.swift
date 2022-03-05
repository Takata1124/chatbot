//
//  MovieViewModel.swift
//  chatbot
//
//  Created by t032fj on 2022/02/24.
//

import Foundation
import SwiftGoogleTranslate
import SwiftUI
import Alamofire
import SwiftyJSON

class MovieViewModel: NSObject, ObservableObject {
    
    var apiKey: String = Apikey().apikey
    var movieArray: [String] = []
    var movieCateArray: [MovieArray] = []
    
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
                MovieArray(number: number, title: title, category: category, year: year, star: 0))
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
        return tempcsv
    }
    
    func getBotResponse(message: String, nowCount: Int, dataModel: DataModel) -> String {
        
        let tempMessage = message.lowercased()
        switch nowCount {
            
        case 1:
            let returnMessage = firstSession(tempMessage: tempMessage)
            return returnMessage
            
        case 2:
            
            let returnMessage = secondSession(tempMessage: tempMessage)
            print(returnMessage)
            let title = recommendTitle(datamodel: dataModel, genre: returnMessage, reloadPoint: 0)
            print(title)
            return title
            
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
        
        if separetedArray != [] {
            print(separetedArray[0].initialUppercased())
            return separetedArray[0].initialUppercased()
        } else {
            let void: String = "void"
            return void
        }
    }
    
    func recommendTitle(datamodel: DataModel, genre: String, reloadPoint: Int) -> String {
        
        var movieArray: [String] = loadCSV(fileName: "movies")
        movieArray.remove(at: 0)
        
        var tempArray: [String] = loadCSV(fileName: "ratings")
        tempArray.remove(at: 0)
        
        var countArray: [String] = []
        tempArray.forEach { element in
            let index = element.components(separatedBy: ",")[0]
            if !countArray.contains(index) {
                countArray.append(index)
            }
        }
        
        if datamodel.tapArray != [] {
            var arrayTemp: [String] = []
            for element in datamodel.tapArray {
                let temp: [String] = tempArray.filter { $0.components(separatedBy: ",")[1] == element.id }
                arrayTemp += temp
            }
            
            let temptemp: [String] = arrayTemp.sorted { Int($0.components(separatedBy: ",")[0])! < Int($1.components(separatedBy: ",")[0])! }
            
            var dic: [[Int]] = []
            for i in 1..<countArray.count + 1 {
                let t = temptemp.filter { Int($0.components(separatedBy: ",")[0]) == i }
                let count = t.count
                let tArray: [Int] = [i, count]
                dic.append(tArray)
            }
            
            let sortedDic = dic.sorted { $0[1] > $1[1] }
            let filteredArray: [String] = tempArray.filter { Int($0.components(separatedBy: ",")[0]) == Int(sortedDic[0][0])}
            let filteredArray_1: [String] = tempArray.filter { Int($0.components(separatedBy: ",")[0]) == Int(sortedDic[1][0])}
            let filteredArray_2: [String] = tempArray.filter { Int($0.components(separatedBy: ",")[0]) == Int(sortedDic[2][0])}
            let totalFilterArray = filteredArray + filteredArray_1 + filteredArray_2
            let tempfilteredArray = totalFilterArray.filter{ Double($0.components(separatedBy: ",")[2]) == 5.0}
            
            var filteredMovieArray: [String] = []
            
            tempfilteredArray.forEach { elements in
                let dataId = elements.components(separatedBy: ",")[1]
                let genre: [String] = movieArray.filter{ $0.components(separatedBy: ",")[0] == dataId }
                filteredMovieArray += genre
            }
            
            let recommendArray = filteredMovieArray.filter{ $0.components(separatedBy: ",").last?.contains(genre) as! Bool }
            
            let newRecommendArray = recommendArray.sorted { Int($0.components(separatedBy: ",")[0])! > Int($1.components(separatedBy: ",")[0])! }
            
            var array = newRecommendArray[reloadPoint].description.components(separatedBy: ",")
            array.removeFirst()
            array.removeLast()
            
            return array[0]
        }
        
        return "評価を入れてください"
    }
    
    func getArticle(title: String) -> [String] {

        let url = "https://en.wikipedia.org/api/rest_v1/page/summary/\(title)"
        
        var jsonArray: [String] = []
        
        AF.request(url).responseJSON { response in
            do {
                let json = JSON(response.data)
                
                guard let title = json["title"].string else { return }
                print(type(of: title))
                guard let extract = json["extract"].string else { return }
                print(type(of: extract))
                guard let imageUrl = json["thumbnail"]["source"].string else { return }
                print(type(of: imageUrl))
                
                jsonArray.append(title)
                jsonArray.append(extract)
                jsonArray.append(imageUrl)
                
                print(jsonArray)
            } catch {
                print("デコードに失敗しました")
            }
        }

        return jsonArray
    }
}
