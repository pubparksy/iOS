//
//  FinTableViewController.swift
//  FinSearchApp
//
//  Created by soyoung Park on 9/8/24.
//

import UIKit

class FinTableViewController: UITableViewController {
    /** 공공데이터 키 필요 */
    let encodingKey = "lzyJeCYYMKxGYIApLDSl0ALEqxtoOlDd6ksRAPMZ49UYFq5vIAfGYOcURSWKp0zy9DX18dtHAL28MVbL64Dvgw%3D%3D"
    
    /** 현시점 중앙은행 [국내사이트 - 금융기관] 명시 기준 .  초기화면  section별 구분 후 선택 시 관련 기관 별 상품 조회하도록 DetailView? */
    let bank = ["국민은행", "신한은행", "우리은행", "하나은행", "한국스탠다드차타드은행", "중소기업은행"]
    let nonBank = ["(주)SBI저축은행", "(주)IBK저축은행", "(주)키움예스저축은행", "(주)키움저축은행", "푸른상호저축은행"]
    let ivmCom = ["KB증권주식회사", "엔에이치투자증권", "교보증권주식회사", "대신증권주식회사", "미래에셋증권 주식회사", "삼성증권 주식회사", "한국투자증권주식회사"]
    
    var companyList:[[String:String]]?
    var companyNmList:[String] = []
    
    var itemList:[[String:String]]?
    var itemPrdNmList:[String] = []
    var itemFncIstNmList:[String] = []
    var itemRegDateList:[String] = []
    var itemPrdSalDscnDtList:[String] = []
    
    
    
    var page = 1 
    {
        didSet {
//            search(searchBar.text)
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPrev.isHidden = true
        btnNext.isHidden = true
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section {
            case 0: return "은행"
            case 1: return "비은행"
            case 2: return "증권회사"
            default:return ""
            }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "init", for: indexPath)
        let lbl = cell.viewWithTag(12) as? UILabel
        
        if indexPath.section == 0 {
            lbl?.text = bank[indexPath.row]
        } else if indexPath.section == 1 {
            lbl?.text = nonBank[indexPath.row]
        } else if indexPath.section == 2 {
            lbl?.text = ivmCom[indexPath.row]
        }
        btnPrev.isHidden = true
        btnNext.isHidden = true

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
        page = 1
        
        searchBar.resignFirstResponder()
        performSegue(withIdentifier: "result", sender: nil)
        
    }
    
}
