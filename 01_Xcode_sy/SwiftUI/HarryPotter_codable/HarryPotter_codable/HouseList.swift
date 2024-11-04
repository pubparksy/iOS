import SwiftUI

struct HouseList: View {
    @State private var schools: [String] = ["Hogwarts"]
//    var houses: [House] // JSON에서 디코드된 데이터
    
    var groupedHouses: [String: [House]] {
        Dictionary(grouping: houses, by: { $0.school.name })
    }
    /**
     Dictionary(grouping:by:)  => 배열을 기반으로 새로운 딕셔너리를 생성. 첫 번째 인자는 배열(houses), 두 번째 인자는 그룹화의 기준이 되는 클로저.
     => 같은 학교 이름을 가진 House 객체들이 같은 키(학교 이름) 아래에 모이게 된다.
     
     $0은 Swift 클로저(closure) 내에서 사용되는 기본 매개변수 이름.
     클로저의 매개변수를 명시적으로 정의하지 않으면, Swift는 자동으로 $0, $1와 같은 이름을 사용.
     $0은 houses 배열의 각 요소, 즉 House 객체.
     
     결론. 구조는 groupedHouses.keys = "호그와트 Hogwarts", "보바통 Beauxbatons"
     [
         "호그와트 Hogwarts": [
             House(school: School(name: "호그와트 Hogwarts", country: "United Kingdom"), house: "그리핀도르 Gryffindor", ...),
             House(school: School(name: "호그와트 Hogwarts", country: "United Kingdom"), house: "슬리데린 Slytherin", ...),
             House(school: School(name: "호그와트 Hogwarts", country: "United Kingdom"), house: "레번클로 Ravenclaw", ...),
             House(school: School(name: "호그와트 Hogwarts", country: "United Kingdom"), house: "후플푸프 Hufflepuff", ...)
         ],
         "보바통 Beauxbatons": [
             House(school: School(name: "보바통 Beauxbatons", country: "France"), house: "에큐르유 Écureuil", ...),
             House(school: School(name: "보바통 Beauxbatons", country: "France"), house: "파피용리즈 Papillonlisse", ...),
             House(school: School(name: "보바통 Beauxbatons", country: "France"), house: "세르펜타르 Serpentard", ...)
         ]
     ]
     */
    
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
/**
  sorted(by: >): groupedHouses.keys를 내림차순 정렬 (필요에 따라 오름차순으로 정렬)
  sorted(by: { $0.house > $1.house }): 각 섹션 내의 houses를 house 속성을 기준으로 내림차순 정렬.
 
 1. 사전식 정렬 : 문자열의 첫 번째 문자부터 비교. 만약 첫 번째 문자가 같다면, 두 번째 문자를 비교.
   ag. "Gryffindor"와 "Hufflepuff"를 비교하면 'G'가 'H'보다 먼저 오기 때문에 "Gryffindor"가 더 작다고 평가.
      만약 첫 번째 문자가 같아서
      "Gryffindor"와 "Gufflepuff"를 비교하면 'r'가 'u'보다 먼저 오기 때문에 "Gryffindor"가 더 작다고 평가.

 2. 비교 연산자: 부등호 연산자는 두 문자열을 사전식으로 비교하여 첫 번째 문자열이 두 번째 문자열보다 먼저 오는지를 판별합니다. 결과는 (true 또는 false).
 */
                
                ForEach(groupedHouses.keys.sorted(by: >), id: \.self) { schoolName in
                    Section(header: Text(schoolName)) {
                        // 각 섹션 내의 house를 역순으로 정렬
                        ForEach(groupedHouses[schoolName]?.sorted(by: { $0.house < $1.house }) ?? [], id: \.self) { house in
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
