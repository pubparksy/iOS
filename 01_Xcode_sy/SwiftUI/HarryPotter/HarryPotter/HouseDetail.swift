import SwiftUI

struct HouseDetail: View {
    var house:House
    var body: some View {
        VStack {
            MapView(coordinate: house.locationCoordinate).frame(height: 300)
            
            CircleImage(image: house.imageHouse)
                .offset(y: -130) // CircleImage 보이는 위치만 옮기고 밑은 비어있는 상태
                .padding(.bottom, -130)   // 패딩을 줄여서, 밑의 Text뷰들이랑 가까워지게함
            
            VStack(alignment: .leading) {
                
                Text(house.house)
                    .font(.title)
                HStack {
                    Image(house.schoolName)
                    Text(house.schoolName)
                    Spacer()
                    Text(house.country)
                }.font(.subheadline)  // 각 Text뷰에 적용 안하고 HStack에서 한꺼번에 적용시키기
                 .foregroundStyle(.secondary)
                
                Divider()  // 실선
                Text("About \(house.house)").font(.title2)
                Text(house.comment) // landmarkData.json에서 가져올거임
                Text("Color : \(house.color)")
                Text("Logo : \(house.logo)")
            }.padding()
            Spacer()
        }
    }
}

#Preview {
    HouseDetail(house: houses[0])
}
