import Foundation
import SwiftUI

var houses:[House] = load("HarryPotterData.json")

func load<T:Decodable>(_ filename:String) -> T {
    // 1. Bundle Cotainer에서 json 파일 가져와서 data에 담기
    let data:Data
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil)
    else { fatalError("There is no file in Main Bundle") }
    
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Cannot read file in Main Bundle")
    }
    
    // 2. data를 decoding
    do {
//        let decoder = JSONDecoder()
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Cannot read file in Main Bundle")
    }
    
}

/**
 기존엔 func load 함수 1개만 있었는데...
 
 아예 class를 만들고,
    그 안에 func load 함수를 넣어버린!!!!!!!
 */


//class ImageViewModel: ObservableObject {
//    @Published var image: String = "defaultHous" // 기본 이미지 이름
//    
//    func load<T:Decodable>(_ filename:String) -> T {
//        // 1. Bundle Cotainer에서 json 파일 가져와서 data에 담기
//        let data:Data
//        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil)
//        else { fatalError("There is no file in Main Bundle") }
//
//        // 2. data를 decoding
//        do {
//            data = try Data(contentsOf: fileURL)
//            
////          let jsonData = try decoder.decode([String: String].self, from: data)
//            let jsonData = try JSONDecoder().decode(T.self, from: data)
//            
//            // 존재하는 이미지 파일 확인
//            for (key, value) in jsonData {
//                if let _ = UIImage(named: value) {
//                    image = value // 파일이 존재하면 해당 이미지
//                    break
//                }
//            }
//            return jsonData // 이미지 정리한거 리턴
//        } catch {
//            fatalError("Cannot read file in Main Bundle")
//        }
//    }
//}


class ImageViewModel: ObservableObject {
    @Published var image: String = "defaultHouse" // 기본 이미지 이름
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("There is no file in Main Bundle")
        }
        
        do {
            data = try Data(contentsOf: fileURL)
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            
            // Mirror를 사용하여 `T`의 프로퍼티들을 반복하면서 이미지 파일 확인
            let mirror = Mirror(reflecting: jsonData)
            for child in mirror.children {
                if let value = child.value as? String, UIImage(named: value) != nil {
                    image = value // 파일이 존재하면 해당 이미지 설정
                    break
                }
            }
            
            return jsonData
        } catch {
            fatalError("Cannot read file in Main Bundle")
        }
    }
}
