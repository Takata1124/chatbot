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
import Firebase
import RealmSwift

class MovieViewModel: NSObject, ObservableObject {
    
    var apiKey: String = Apikey().apikey
    var movieArray: [String] = []
    var movieCateArray: [MovieArray] = []
    
    override init() {
        super.init()
        
        let array = loadCSV(fileName: "movies")
        self.movieArray = array
        
        var number: String = "0"
        var title: String = ""
        var category: String = "???"
        var year: String = "???"
        
        for i in  1..<self.movieArray.count {
            var splitedArray: [String] = array[i].components(separatedBy: ",")
            
            number = splitedArray.first ?? "???"
            category = splitedArray.last ?? "???"
            
            splitedArray.removeLast()
            splitedArray.remove(at: 0)
            
            splitedArray.forEach { str in
                title += str
            }
            
            var separatedTitle: [String] = title.components(separatedBy: "(")
            separatedTitle.removeLast()
            title  =  ""
            
            separatedTitle.forEach { str in
                title += str
            }
            
            if array[i].contains(")") {
                var splitedYearArray: [String] = array[i].components(separatedBy: ",")
                splitedYearArray.removeLast()
                let tempYear = splitedYearArray.last?.components(separatedBy: "(")
                let newYear = tempYear?.last?.components(separatedBy: ")")
                year = (newYear?[0])!
            }
            movieCateArray.append(
                MovieArray(number: number, title: title, category: category, year: year, star: 0))
            
            title  =  ""
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
            if csv == "" { } else {  tempcsv.append(csv) }
        }
        return tempcsv
    }
    
    func getBotResponse(message: String, nowCount: Int, dataModel: DataModel, completion: @escaping (_ message: String) -> Void)  {
        
        let tempMessage = message.lowercased()
        switch nowCount {
            
        case 1:
            let returnMessage = firstSession(tempMessage: tempMessage)
            completion(returnMessage)
            
        case 2:
            let returnMessage = secondSession(tempMessage: tempMessage, dataModel: dataModel)
            completion(returnMessage)
            
        case 3:
            thirdSession(tempMessage: tempMessage, dataModel: dataModel) { returnMessage in
                completion(returnMessage)
            }
            
        case 4:
            forthSession(dataModel: dataModel, tempMessage: tempMessage) { message in
                completion(message)
            }
            
        default:
            completion("またよろしくお願いします")
        }
    }
    
    private func firstSession(tempMessage: String) -> String {
        
        if tempMessage.contains("はい") {
            return "見たい映画は新しい映画ですか？昔の映画ですか？"
        } else {
            return "またよろしくお願いします"
        }
    }
    
    private func secondSession(tempMessage: String, dataModel: DataModel) -> String {
        
        if tempMessage.contains("新しい") {
            dataModel.newYear = true
        } else {
            
            dataModel.newYear = false
        }
        return "見たい映画のジャンルを教えてください(アクション/冒険/アニメーション/子供たち/コメディ/ファンタジー/ロマンス/ドラマ/犯罪/スリラー/ホラー/ミステリー/SF)"
    }
    
    private func thirdSession(tempMessage: String, dataModel: DataModel, completion: @escaping (_ returnMessage: String) -> Void) {
        
        switch tempMessage {
            
        case "他へ":
            dataModel.reloadInt += 1
            if dataModel.reloadInt == dataModel.totalInt {
                dataModel.reloadInt = 0
            }
            var recommendTitle = recommendTitle(datamodel: dataModel, genre: dataModel.tempJenre, reloadPoint: dataModel.reloadInt)
            dataModel.tempTitle = recommendTitle
            recommendTitle = recommendTitle + " " + "(" + dataModel.tempYear + ")"
            completion(recommendTitle)
            
        default:
            dataModel.reloadInt = 0
            let returnMessage = englishTranslate(translatingText: tempMessage)
            dataModel.tempJenre = returnMessage
            var recommendTitle = recommendTitle(datamodel: dataModel, genre: dataModel.tempJenre, reloadPoint: dataModel.reloadInt)
            dataModel.tempTitle = recommendTitle
            recommendTitle = recommendTitle + " " + dataModel.tempYear
            completion(recommendTitle)
        }
    }
    
    private func forthSession(dataModel:DataModel, tempMessage: String, completion: @escaping (_ message: String) -> Void) {
        
        var message = "すみませんが詳細データが見つかりませんでした"
        
        switch tempMessage {
            
        case "詳細":
            getArticle(dataModel: dataModel, title: dataModel.tempTitle ) { titleArray in
                message = titleArray[1]
                completion(message)
            }
            
        case "他へ":
            dataModel.reloadInt += 1
            if dataModel.reloadInt == dataModel.totalInt {
                dataModel.reloadInt = 0
            }
            var recommendTitle = recommendTitle(datamodel: dataModel, genre: dataModel.tempJenre, reloadPoint: dataModel.reloadInt)
            dataModel.tempTitle = recommendTitle
            recommendTitle = recommendTitle + " " + "(" + dataModel.tempYear + ")"
            completion(recommendTitle)
            
        default:
            completion(message)
        }
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
        sleep(2)
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
            var newRecommendArray: [String] = []
            
            newRecommendArray = recommendArray
            
            if datamodel.newYear == true {
                newRecommendArray = recommendArray.sorted { Int($0.components(separatedBy: ",")[0])! > Int($1.components(separatedBy: ",")[0])! }
            }

            print(newRecommendArray)
            print(newRecommendArray.count)
            print(reloadPoint)
            
            datamodel.totalInt = newRecommendArray.count
            
            var array = newRecommendArray[reloadPoint].description.components(separatedBy: ",")
            
            datamodel.tempCategory = array.last ?? ""
            array.removeFirst()
            array.removeLast()
            
            let recommendTitle = array[0]
            
            if recommendTitle.contains("(") {
                var recommend = recommendTitle.description.components(separatedBy: "(")
                let recommendYear = recommend.removeLast()
                let year = recommendYear.components(separatedBy: ")")[0]
                datamodel.tempYear = year
                let deleteRecomend = recommend[0].trimmingCharacters(in: .whitespaces)
                return deleteRecomend
            }
            return recommendTitle
        }
        return "評価を入れてください"
    }
    
    func getArticle(dataModel:DataModel, title: String, completion: @escaping (_ titleArray: [String]) -> Void){
        
        print(title)
        
        var replaceString: String = ""
        if title.contains(" "){
            replaceString = title.replacingOccurrences(of: " ", with: "_")
        } else {
            replaceString = title
        }
        
        let url = "https://en.wikipedia.org/api/rest_v1/page/summary/\(replaceString)"
        var jsonArray: [String] = []
        
        AF.request(url).responseJSON { response in
            
            do {
                let json = JSON(response.data)
                
//                print(json)
                guard let title = json["title"].string else { return }
                guard let extract = json["extract"].string else { return }
                let imageUrl = json["thumbnail"]["source"].string
                
                jsonArray.append(title)
                jsonArray.append(extract)
                
                if imageUrl != nil {
                    dataModel.tempImageUrl = imageUrl!
                }
                completion(jsonArray)
            } catch {
                print("デコードに失敗しました")
            }
        }
    }
    
    func saveEvaluateData(dataModel: DataModel) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        if dataModel.tapArray == [] { return }
        
        dataModel.tapArray.forEach { tap in
            
            let docData = [
                "id": tap.id,
                "title": tap.title,
                "star": tap.star,
            ] as [String: Any]
            
            Firestore.firestore().collection("users").document(uid).collection("starArray").addDocument(data: docData) { (err) in
                
                if let err = err {
                    print("保存に失敗しました")
                    return
                }
                print("保存に成功しました")
            }
        }
    }
    
    func deleteEvaluateData(dataModel: DataModel) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("starArray").getDocuments { (snapshot, error) in
            if let error = error{
                print("エラー",error)
                return
            }
            for document in snapshot!.documents{
                document.reference.delete()
                print("削除")
            }
        }
    }
    
    func fetchEvaluateData(dataModel: DataModel) {
        
        dataModel.tapArray = []
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("starArray").getDocuments { documents, error in
            
            documents?.documents.forEach({ document in
                
                let dic = document.data()
                let decodeArray = DecodeTapArray(dic: dic)
                dataModel.tapArray.append(TapArray(id: decodeArray.id, title: decodeArray.title, star: decodeArray.star))
            })
        }
        
        print(dataModel.tapArray)
    }
    
    func savePostData(dataModel: DataModel, authViewModel: AuthViewModel, star: Int, review: String, collectionName: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let date: Date = Date()
        let unixtime: Int = Int(date.timeIntervalSince1970)
        
        let docData = [
            "title": dataModel.tempTitle,
            "category": dataModel.tempCategory,
            "year": dataModel.tempYear,
            "star": star,
            "review": review,
            "imageUrl": dataModel.tempImageUrl,
            "uid": uid,
            "username": authViewModel.userData!.username as String,
            "userImageUrl": authViewModel.userData!.ImageUrl,
            "createdAt": unixtime,
        ] as [String: Any]
        
        Firestore.firestore().collection("users").document(uid).collection(collectionName).addDocument(data: docData) { (err) in
            
            if let err = err {
                print("保存に失敗しました")
                return
            }
            print("保存に成功しました")
        }
    }
    
    func fetchPostData(dataModel: DataModel, collectionName: String) {
        
        dataModel.postViewArray = []

        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(uid).collection(collectionName)
            .order(by: "createdAt", descending: true)
            .getDocuments { documents, error in
            
            if let error = error {
                print("データの取得に失敗しました")
                return
            }
            
            documents?.documents.forEach({ document in
                
                let dic = document.data()
                let decodeArray = PostDataArray(dic: dic)
   
                    dataModel.postViewArray.append(decodeArray)
                    print("データの取得に成功しました")
                
            })
        }
    }
    
    func saveRealmReseveeData(dataModel:DataModel, authViewModel: AuthViewModel, star: Int, review: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let realm = try! Realm()
        
        let date: Date = Date()
        let unixtime: Int = Int(date.timeIntervalSince1970)
        
        let reserve = Reserve()
        
        reserve.id = "1"
        reserve.title = dataModel.tempTitle
        reserve.category = dataModel.tempCategory
        reserve.year = dataModel.tempYear
        reserve.star = star
        reserve.review = review
        reserve.imageUrl = dataModel.tempImageUrl
        reserve.uid = uid
        reserve.username = authViewModel.userData!.username as String
        reserve.userImageUrl = authViewModel.userData!.ImageUrl
        reserve.createdAt = unixtime
        
        try! realm.write {
          realm.deleteAll()
        }
        
        try! realm.write({
            realm.add(reserve)
        })
    }
    
    func fetchRealmReserveData(dataModel: DataModel) {
        let id = "1"
        let predicate = NSPredicate(format: "id == %@", id)
        
        let realm = try! Realm()
        
        let results = realm.objects(Reserve.self)
        print(results)
        
        if let reserve = realm.objects(Reserve.self).filter(predicate).first {
//            print(reserve)
//            print(reserve.title)
            
            let docData = [
                "title": reserve.title,
                "category": reserve.category,
                "year": reserve.year,
                "star": reserve.star,
                "review": reserve.review,
                "imageUrl": reserve.imageUrl,
                "uid": reserve.uid,
                "username": reserve.username,
                "userImageUrl": reserve.userImageUrl,
                "createdAt": reserve.createdAt,
            ] as [String: Any]
            
            dataModel.reserveData = PostDataArray(dic: docData)
        }
    }
}
