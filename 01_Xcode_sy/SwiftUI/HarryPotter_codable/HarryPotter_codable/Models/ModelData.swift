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
            
            // Mirror를 사용하여 T의 프로퍼티들을 반복하면서 이미지 파일 확인
            let mirror = Mirror(reflecting: jsonData)
            for child in mirror.children {
                if let value = child.value as? String {
                    if UIImage(named: value) != nil {
                        image = value // 파일이 존재하면 해당 이미지 설정
                    } else {
                        image = "defaultHouse" // 파일이 없으면 기본 이미지 설정
                    }
                    break
                }
            }
            
            return jsonData
        } catch {
            fatalError("Cannot read file in Main Bundle")
        }
    }
}
