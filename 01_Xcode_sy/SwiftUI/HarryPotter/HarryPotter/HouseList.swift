import SwiftUI



struct HouseList: View {
    @State var nowSchoolNm:[String] = ["Hogwarts"]
    var body: some View {
        NavigationSplitView {
            List(houses, id: \.id) { house in
                if nowSchoolNm.contains(house.schoolName) {
                    NavigationLink {
                        HouseDetail(house: house) // 도착 뷰
                    } label: {
                        HouseRow(house: house) // 보여줄 List의 Row 한줄 디자인
                    }
                } else {
                    Section {
                        
                        NavigationLink {
                            HouseDetail(house: house) // 도착 뷰
                        } label: {
                            HouseRow(house: house) // 보여줄 List의 Row 한줄 디자인
                        }
                    }
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
