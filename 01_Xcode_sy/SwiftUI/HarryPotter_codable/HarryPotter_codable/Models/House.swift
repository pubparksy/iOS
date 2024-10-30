import Foundation
import SwiftUI
import CoreLocation

struct House: Identifiable, Codable { // id가 없으면 Hashable
    var id = UUID()
    var school:School
    var house:String
    var color:String
    var logo:String
    var comment:String
    
    var coordinates:Coordinate
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    
    var schoolImgName:String
    var schoolImg:Image{
        Image(schoolImgName)
    }
    private var houseImgName:String
    var houseImg:Image{
        Image(houseImgName) // 없으면... house.lodge.fill로 하고 싶음...
    }
    
    
    // school에 대한 구조체
    struct School:Hashable, Codable {
        var name:String
        var country:String
    }
    // coordinates에 대한 구조체
    struct Coordinate:Hashable, Codable {
        var latitude:Double
        var longitude:Double
    }
}

