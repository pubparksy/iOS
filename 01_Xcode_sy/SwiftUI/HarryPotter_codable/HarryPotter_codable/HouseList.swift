import SwiftUI


struct HouseList: View {
    @State private var schools: [String] = ["Hogwarts"]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(houses.filter { !schools.contains($0.schoolImgName) }, id: \.id) { house in
                    Section {
                        NavigationLink {
                            HouseDetail(house: house)
                        } label: {
                            HouseRow(house: house)
                        }
                    }
                }
                
                ForEach(houses.filter { schools.contains($0.schoolImgName) }, id: \.id) { house in
                    NavigationLink {
                        HouseDetail(house: house)
                    } label: {
                        HouseRow(house: house)
                    }
                }
            }
            .navigationTitle("Houses")
        } detail: {
            Text("Select a house")
        }
        .onAppear {
            // schools 배열을 업데이트합니다.
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
