//
//  ViewController.swift
//  SBTableView-DefaultConfig-Reuse
//
//  Created by soyoung Park on 9/6/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    let coffee = ["커피1", "커피2", "커피3", "커피4", "커피5", "커피6", "커피7", "커피8", "커피9", "커피10", "커피11", "커피12", "커피13", "커피14", "커피15", "커피16", "커피17", "커피18", "커피19", "커피20", "커피21", "커피22", "커피23", "커피24", "커피25", "커피26", "커피27", "커피28", "커피29", "커피30", "커피31", "커피32", "커피33", "커피34", "커피35", "커피36", "커피37", "커피38", "커피39", "커피40", "커피41", "커피42", "커피43", "커피44", "커피45", "커피46", "커피47", "커피48", "커피49", "커피50"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }


//    func numberOfSections(in tableView: UITableView) -> Int {  // 정의 안하면 기본 갯수 1개
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coffee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Prototype Cells가 없는 소스. Doc Outline에서도 Cell이 없으니까 Id도 지정 안함
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        print(cell)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            //                     style: custom cell 아니고 기본 defaultConfiguration 아래 저거
        }

        
        var config = cell?.defaultContentConfiguration() // 옵셔널 체이닝 = if let cell1 = cell {
        config?.text = coffee[indexPath.row]
        config?.textProperties.color = .purple
        
        cell?.contentConfiguration = config
        return cell!
    }
}

