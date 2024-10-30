import SwiftUI

struct HouseRow: View {
    var house:House
    var body: some View {
        HStack {
            house.imageHouse.resizable().frame(width: 50, height: 50)
            Text(house.house)
            Spacer()
        }
    }
}

#Preview {
    HouseRow(house: houses[0])
    HouseRow(house: houses[1])
}
