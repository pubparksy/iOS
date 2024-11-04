import SwiftUI

struct HouseList: View {
    @State private var schools: [String] = ["Hogwarts"]
//    var houses: [House] // JSON에서 디코드된 데이터
    
    var groupedHouses: [String: [House]] {
        Dictionary(grouping: houses, by: { $0.school.name })
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                
// 섹션 키를 오름차순 정렬
//                ForEach(groupedHouses.keys.sorted(), id: \.self) { schoolName in
//                    Section(header: Text(schoolName)) {
//                        ForEach(groupedHouses[schoolName] ?? [], id: \.self) { house in
//                            NavigationLink {
//                                HouseDetail(house: house)
//                            } label: {
//                                HouseRow(house: house)
//                            }
//                        }
//                    }
//                }
   
                
// 섹션 키를 내림차순으로 정렬
// sorted(by: >): groupedHouses.keys를 내림차순 정렬 (필요에 따라 오름차순으로 정렬)
// sorted(by: { $0.house > $1.house }): 각 섹션 내의 houses를 house 속성을 기준으로 내림차순 정렬
                
                ForEach(groupedHouses.keys.sorted(by: >), id: \.self) { schoolName in
                    Section(header: Text(schoolName)) {
                        // 각 섹션 내의 house를 역순으로 정렬
                        ForEach(groupedHouses[schoolName]?.sorted(by: { $0.house > $1.house }) ?? [], id: \.self) { house in
                            NavigationLink {
                                HouseDetail(house: house)
                            } label: {
                                HouseRow(house: house)
                            }
                        }
                    }
                }
                
                
            }
            .navigationTitle("Houses")
            } detail: {
            Text("Select a house")
        }
        .onAppear {
            // 학교 이름 배열을 업데이트합니다.
            for house in houses {
                if !schools.contains(house.schoolImgName) {
                    schools.append(house.schoolImgName)
                }
            }
        }
    }
}
#Preview {
    HouseList()
}
