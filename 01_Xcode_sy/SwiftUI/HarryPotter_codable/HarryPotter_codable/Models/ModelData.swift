import Foundation

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
    
    // 2. data를 decoing
    do {
//        let decoder = JSONDecoder()
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Cannot read file in Main Bundle")
    }
    
}
