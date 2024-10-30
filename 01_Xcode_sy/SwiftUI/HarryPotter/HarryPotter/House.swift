import Foundation
import SwiftUI
import CoreLocation

struct House: Identifiable, Codable {
    var id:Int
    var schoolName:String
    var country:String
    var house:String
    var color:String
    var logo:String
    var comment:String
    
    private var imageNameSchool:String // 외부에서 접근할 일이 없으니 private 접근제한자
    var imageSchool:Image {
        Image(imageNameSchool)
    }
    private var imageNameHouse:String // 외부에서 접근할 일이 없으니 private 접근제한자
    var imageHouse:Image {
        Image(imageNameHouse)
    }
    
    var coordinates:Coordinate
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude,
                               longitude: coordinates.longitude)
    }
    
    struct Coordinate:Hashable, Codable {
        var latitude:Double
        var longitude:Double
    }
}
