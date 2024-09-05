//
//  ViewController.swift
//  SBTableView-Default
//
//  Created by soyoung Park on 9/5/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let kinds = ["커피","프라푸치노","티","그 외"]

    let arrDicNms = ["커피":["에스프레소 콘 파나", "카라멜 마키아또", "바닐라 빈 라떼", "아이스 카페 모카", "사케라또 아포가토", "커피 스타벅스 더블 샷"]
                , "프라푸치노":["에스프레소 프라푸치노", "자바 칩 프라푸치노","딸기 글레이즈드 크림 프라푸치노", "초콜릿 크림 칩 프라푸치노"]
                , "티":["아이스 유자 민트 티", "자몽 허니 블랙 티",  "아이스 제주 말차 라떼"]
                , "그 외":["시그니처 핫 초콜릿", "우유"]]
    let arrDicFileNms = ["커피":["cf1", "cf2", "cf3", "cf4", "cf5", "cf6"]
                        , "프라푸치노":["fc1", "fc2", "fc3", "fc4"]
                        , "티":["tea1", "tea2", "tea3"]
                        , "그 외":["ot1", "ot2"]]
    var arrMenus:[String]?


    let cfInfo = ["신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료"
    , "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료"
    , "리저브만을 위한 바닐라 빈 시럽이 부드럽게 어우러진 카페 라떼", "신선하게 제조된 더블 샷 믹스에 클래식 시럽을 넣고 에스프레소 샷, 얼음이 어우러져 핸드 쉐이킹한 음료"
    , "민트 잎과 쉐이킹한 리저브 에스프레소를 바닐라 아이스크림에 부어 프레쉬함과 달콤함이 조화롭게 퍼지는 리저브 만의 디저트 음료"
    , "진한 초콜릿 모카 시럽과 풍부한 에스프레소를 신선한 우유 그리고 얼음과 섞어 휘핑크림으로 마무리한 음료로 진한 에스프레소와 초콜릿 맛이 어우러진 커피"
    , "민트 잎과 쉐이킹한 리저브 에스프레소를 바닐라 아이스크림에 부어 프레쉬함과 달콤함이 조화롭게 퍼지는 리저브 만의 디저트 음료"
    , "신선하게 제조된 더블 샷 믹스에 클래식 시럽을 넣고 에스프레소 샷, 얼음이 어우러져 핸드 쉐이킹한 음료"]

    let fcInfo = ["에스프레소 샷의 강렬함과 약간의 단맛이 어우러진 프라푸치노"
    , "커피, 모카 소스, 진한 초콜릿 칩이 입안 가득 느껴지는 스타벅스에서만 맛볼 수 있는 프라푸치노"
    , "상큼&달콤한 딸기와 부드러운 글레이즈드 소스에 바삭한 딸기 토핑을 얹은 프라푸치노. 숙련된 바리스타의 솜씨로 그려낸 특별한 예술 작품을 감상해보세요."
    ,"모카 소스와 진한 초콜릿 칩, 초콜릿 드리즐이 올라간 달콤한 크림 프라푸치노"]

    let teaInfo = ["달콤한 국내산 고흥 유자와 알싸하고 은은한 진저와 상쾌한 민트 티가 조화로운 유자 민트 티"
    , "새콤한 자몽과 달콤한 꿀이 깊고 그윽한 풍미의 스타벅스 티바나 블랙 티의 조화"
    , "차광재배한 어린 녹찻잎을 곱게 갈아 깊고 진한 말차 본연의 맛과 향을 부드럽게 즐길 수 있는 제주 말차 라떼"]

    let otInfo = ["깊고 진한 초콜릿과 부드러운 휘핑크림이 입안에서 사르르 녹는 초콜릿 음료"
    , "부드럽고 담백한 신선한 우유." ]



    let sfSymbols = ["cloud.sleet","fleuron","metronome","theatermasks.fill","fireworks","bird"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        kinds.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = arrDicNms[kinds[section]]?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kind = kinds[indexPath.section]
        arrMenus = arrDicNms[kind]
        
        let cell = UITableViewCell() // 액자 틀 생성
        var config = cell.defaultContentConfiguration()
        
        config.text = arrMenus?[indexPath.row]
        config.textProperties.color = .brown
        config.textProperties.font = UIFont.boldSystemFont(ofSize: 17)
        
        arrMenus = arrDicFileNms[kind]
        if let arrMenus {
            config.image = UIImage(named: arrMenus[indexPath.row])
            config.imageProperties.maximumSize.height = 100
            
            config.secondaryText = arrMenus[indexPath.row]
//          config.secondaryTextProperties.color = .magenta
            config.secondaryTextProperties.color = UIColor(red: 0.1725, green: 0.3608, blue: 0.1137, alpha: 1.0)
            config.secondaryTextProperties.font  = UIFont.systemFont(ofSize: 14)
//          config.secondaryTextProperties.font = UIFont.boldSystemFont(ofSize: 13)
       //   www.ralfebert.com/ios/swift-uikit-uicolor-picker/
        }
        
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return kinds[section]
    }
    
}

