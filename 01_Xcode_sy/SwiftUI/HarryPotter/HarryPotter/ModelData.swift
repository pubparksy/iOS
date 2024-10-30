import Foundation

var houses:[House] = load("harryPotterData.json")

func load<T:Decodable>(_ filename:String) -> T {
    let data:Data
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil)
    else { fatalError("Error1") }
        
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Error2")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Error3")
    }
}
