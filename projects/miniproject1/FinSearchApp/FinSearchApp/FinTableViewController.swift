//
//  FinTableViewController.swift
//  FinSearchApp
//
//  Created by soyoung Park on 9/8/24.
//

import UIKit

class FinTableViewController: UITableViewController {
    /** 현시점 중앙은행 [국내사이트 - 금융기관] 명시 기준 .  초기화면  section별 구분 후 선택 시 관련 기관 별 상품 조회하도록 DetailView? */
    let bank = ["국민은행", "신한은행", "우리은행", "하나은행", "한국스탠다드차타드은행", "중소기업은행"]
    let nonBank = ["(주)SBI저축은행", "(주)IBK저축은행", "(주)키움예스저축은행", "(주)키움저축은행", "푸른상호저축은행"]
    let ivmCom = ["KB증권주식회사", "엔에이치투자증권", "교보증권주식회사", "대신증권주식회사", "미래에셋증권 주식회사", "삼성증권 주식회사", "한국투자증권주식회사"]
    
    let bankImg = ["bank1", "bank2", "bank3", "bank4", "bank5", "bank6"]
    let nonBankImg = ["nonBank1", "nonBank2", "nonBank3", "nonBank4", "nonBank5"]
    
    var companyList:[[String:String]]?
    var companyNmList:[String] = []
    
    var itemList:[[String:String]]?
    var itemPrdNmList:[String] = []
    var itemFncIstNmList:[String] = []
    var itemRegDateList:[String] = []
    var itemPrdSalDscnDtList:[String] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0: return bank.count
            case 1: return nonBank.count
            case 2: return ivmCom.count
            default:return 0
            }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        
        switch section {
            case 0:  header?.textLabel?.text = "은행"
            case 1:  header?.textLabel?.text = "비은행"
            case 2:  header?.textLabel?.text = "증권회사"
            default: header?.textLabel?.text = ""
        }
        
        header?.textLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        header?.textLabel?.textColor = .black

        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "init", for: indexPath)
        let img = cell.viewWithTag(11) as? UIImageView
        let lbl = cell.viewWithTag(12) as? UILabel
        
        if indexPath.section == 0 {
            img?.image = UIImage(named: bankImg[indexPath.row])
            lbl?.text = bank[indexPath.row]
        } else if indexPath.section == 1 {
            img?.image = UIImage(named: nonBankImg[indexPath.row])
            lbl?.text = nonBank[indexPath.row]
        } else if indexPath.section == 2 {
            img?.image = UIImage(systemName: "banknote")
            lbl?.text = ivmCom[indexPath.row]
        }

        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as? ResultViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            var company = ""
            switch indexPath.section {
                case 0:  company = bank[indexPath.row]
                case 1:  company = nonBank[indexPath.row]
                case 2:  company = ivmCom[indexPath.row]
                default: company = ""
            }
            
            resultVC?.company = company
        } else {
            resultVC?.searchBarKeyword = searchBar.text
        }
    }

}

extension FinTableViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSegue(withIdentifier: "result", sender: nil)
        
    }
    
}
