import SwiftUI
import MapKit

struct MapView: View {
    var coordinate:CLLocationCoordinate2D
    var region:MKCoordinateRegion {
        let center = coordinate
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    var body: some View {
        Map(initialPosition: .region(region))
    }
}

#Preview {
    MapView(coordinate: houses[0].locationCoordinate)
}
