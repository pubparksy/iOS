import SwiftUI
import MapKit

struct MapView: View {
    var region: MKCoordinateRegion {
        // center : 현재 좌표 잡기, span : 배율 설정
        let center = CLLocationCoordinate2D(latitude: 53.395518266436994, longitude: -3.0428566794599807)
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        return MKCoordinateRegion(center: center, span: span) // 단일행으로 쓸거면 return 안 씀
    }
    
    var body: some View {
        Map(initialPosition: .region(region))
    }
}

#Preview {
    MapView()
}
