import SwiftUI

struct HouseList: View {
    var body: some View {
        NavigationSplitView {
            List(houses, id: \.id) { house in
                NavigationLink {
                    HouseDetail(house: house) // 도착 뷰
                } label: {
                    HouseRow(house: house) // 보여줄 List의 Row 한줄 디자인
                }
            }
            .navigationTitle("Houses")
        } detail: { // ipad용
            Text("Select a house")
        }

    }
}

#Preview {
    HouseList()
}
