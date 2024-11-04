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
            
            return jsonData
        } catch {
            fatalError("Cannot read file in Main Bundle")
        }
    }
}
