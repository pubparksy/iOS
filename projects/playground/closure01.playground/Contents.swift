//  key = groupNm : val = members
let sm = [
  "redvelvet" : ["아이린", "슬기", "웬디", "조이", "예리"],
  "aespa" : ["카리나", "지젤", "윈터", "닝닝"]
]


func selectMembers(members:[String]) {
    print("멤버 이름은 \(members)입니다.");
}

func doSomething(enter:[String:[String]],handler:([String])->()) {
    for group in enter {
        print("그룹 영문명은 \(group.key)입니다.")
        handler(group.value)
    }
}

doSomething(enter: sm, handler: selectMembers)
