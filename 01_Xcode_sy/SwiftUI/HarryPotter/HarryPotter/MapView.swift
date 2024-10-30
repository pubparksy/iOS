import SwiftUI
import MapKit

struct MapView: View {
    var coordinate:CLLocationCoordinate2D
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    }
    var body: some View {
        Map(initialPosition: .region(region))
    }
}

#Preview {
    MapView(coordinate: houses[0].locationCoordinate)
}
