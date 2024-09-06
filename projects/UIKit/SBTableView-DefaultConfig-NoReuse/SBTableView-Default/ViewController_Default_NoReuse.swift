//
//  ViewController.swift
//  SBTableView-Default
//
//  Created by soyoung Park on 9/5/24.
//

import UIKit

class ViewController_Default_NoReuse: UIViewController, UITableViewDataSource {
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
        
        print(cell)
        
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

