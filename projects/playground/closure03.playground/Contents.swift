import CoreFoundation

let data =
[
"yg" : [
    "girlGroupInfo" : [
        "2NE1" : ["박봄", "다라", "CL", "민지"],
        "BLACK PINK" : ["지수", "제니", "로제", "리사"]
    ],
    "boyGroupInfo" : [
        "BINBANG" : ["지드래곤","태양","대성"],
        "WINNER" : ["강승윤", "김진우", "송민호", "이승훈"]
    ],
    "label" : [
        "epikhigh": ["이선웅","김정식","최진"]
    ]
  ],
"sm" : [
      "girlGroupInfo" : [
          "redvelvet" : ["아이린", "슬기", "웬디", "조이", "예리"],
          "aespa" : ["카리나", "지젤", "윈터", "닝닝"]
      ],
      "boyGroupInfo" : [
          "shinee" : ["온유", "종현", "키", "민호", "태민"],
          "NCT Dream" : ["마크","제노","런쥔","해찬","재민","천러","지성"]
          
      ]
  ]
]

func selectEntertainmentNm(data:Any) {
    guard let data = data as? [String:[String:[String:[String]]]] else { return }
                            // yg    : label    epik   member명

    for entertainment in data.keys {
        var groupsItem = data[entertainment] // dictionary 에서 key로 뽑아내면 무조건 value는 옵셔널.
        guard let groupsItem else { return } // 그래서 옵셔널 바인딩해야만 데이터 가공 가능.
        
        for category in groupsItem.keys { // groupStatus = girlGroupInfo,boyGroupInfo,label
            guard let groupItem = groupsItem[category] else { return } // 이렇게 호출하면서 바로 바인딩도 가능.
//          만약 as? [String:[String]]  없이 바인딩하면 group.keys와 .values를 뽑아낼 수가 없음...
//          만약 없이 print(group)하면,  타입 지정하고 print(group)와 동일하게, 데이터는 동일한 포맷은 같아보여도 type 상태는 전혀 다름

            // 엔터의 category별 그룹명 전체 ,  엔터별 멤버명 전체
            print(groupItem.keys , ", " , groupItem.values)
            
        }
    }
    
    // 근데 궁금한게
    for item in data {
//        print(item.value) // 이런거는.. 옵셔널...을 안 취하나? value가 당연히 있단 가정 하에 사용하나...
    }
}

//func doSomething(enter:[String:[String]],handler:([String])->()) {
//    for group in enter {
//        handler(group.value)
//    }
//}

//doSomething(enter: sm, handler: selectMembers)
selectEntertainmentNm(data: data)
