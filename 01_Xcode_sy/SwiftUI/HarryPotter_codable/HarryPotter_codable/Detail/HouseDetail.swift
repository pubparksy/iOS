import SwiftUI

struct HouseDetail: View {
    var house:House
    var body: some View {
        VStack {
            MapView(coordinate: house.locationCoordinate).frame(height: 300)
            CircleImage(image: house.houseImg)
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack (alignment: .leading){
                Text(house.house).font(.title)
                HStack {
                    Image(house.schoolImgName)
                    Text(house.school.name)
                    Spacer()
                    Text(house.school.country)
                }.font(.subheadline)
                .foregroundStyle(.gray)
                
                Divider()
                Text("About \(house.house)").font(.title2)
                Text(house.comment)
            }.padding()
            Spacer()
        }
    }
}

#Preview {
    HouseDetail(house: houses[0])
}
