//
//  FinTableViewController.swift
//  FinSearchApp
//
//  Created by soyoung Park on 9/8/24.
//

import UIKit

class FinTableViewController: UITableViewController {
    /** 공공데이터 키 필요 */

    
    /** 현시점 중앙은행 [국내사이트 - 금융기관] 명시 기준 .  초기화면  section별 구분 후 선택 시 관련 기관 별 상품 조회하도록 DetailView? */
    let bank = ["KEB하나은행", "SC제일은행", "국민은행", "신한은행", "외환은행", "우리은행", "한국시티은행","경남은행", "광주은행", "대구은행", "부산은행", "전북은행", "제주은행", "기업은행", "농협", "수협", "한국산업은행", "한국수출입은행"]
    let nonBank = ["우리종합금융", "SBI저축은행", "애큐온저축은행", "키움YES저축은행", "푸른저축은행", "DB자산운용", "교보악사자산운용", "대신투자신탁운용", "신한BNP파리바자산운용", "유진자산운용", "한화자산운용", "우체국예금보험"]
    let ivmCom = ["KB증권", "NH투자증권", "SK증권", "골든브릿지투자증권", "교보증권", "대신증권", "미래에셋대우", "미래에셋증권", "부국증권", "삼성증권", "신영증권", "유진투자증권", "유화증권", "키움증권", "한국투자증권", "한양증권", "한화증권"]
    
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
    func search(_ query:String?) {
        guard let searchKeyword = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
//        var searchKeyword = ""
//        if let encodedQuery = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//            searchKeyword = encodedQuery
//        }
        
        
        /** 1.  보호대상 금융회사 목록 조회  */
        var endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getCompanyList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=1&numOfRows=284"
        guard let url    = URL(string: endPoint) else { return } // nil이면 더이상 진행이 의미없음. 멈춰.
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error { print("\(error) 발생"); return }
            guard let data else { return }
            
            
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String:Any]]
                    , let list = root["getCompanyList"]
                    , let item = list["item"] as? [[String:String]]
                else { return }
                self.companyList = item
                for comNm in item {
                    if let nm = comNm["fncIstNm"]{
                        self.companyNmList.append(nm)
                    }
                }
                
                
                
                /** 2.  금융회사별 보호대상 금융상품. 검색어가 전체 일치하게 금융회사목록에 있으면 파람 key를 다르게 설정('신한은행'으로는 되지만, '신한'은 안됨) 
                  + 1번 조회하고 2번 조회하면 1번 조회 때 로우가 잔재 */
                if let hangulComNm = query {
                    if self.companyNmList.contains(hangulComNm) {
                        endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getProductList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=1&numOfRows=100&fncIstNm=\(searchKeyword)"
                    } else {
                        endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getProductList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=1&numOfRows=100&prdNm=\(searchKeyword)"
                    }
                }
                guard let url = URL(string: endPoint) else { return }
                request = URLRequest(url: url)
                
                let task2 = session.dataTask(with: request) { data, response, error in
                    if let error { print("\(error) 발생"); return }
                    guard let data else { return }
                    
                    do {
                        guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String:Any]]
                            , let list = root["getProductList"]
                            , let item = list["item"] as? [[String:String]]
                        else { return }
                        
                        for prd in item {
                            
                            if let dt = prd["prdSalDscnDt"],
                                   dt == "" {
                                    
                                    if let val1 = prd["prdNm"],
                                       let val2 = prd["fncIstNm"],
                                       let val3 = prd["prdNm"] {
                                        self.itemPrdNmList.append(val1)
                                        self.itemFncIstNmList.append(val2)
                                        self.itemRegDateList.append(val3)
                                        self.itemPrdSalDscnDtList.append("진행중")
                                    }
                                    
                            } else {
                                // 판매중단 상품까지 담으려면 여기
//                                if let val1 = prd["prdNm"],
//                                   let val2 = prd["fncIstNm"],
//                                   let val3 = prd["prdNm"],
//                                   let val4 = prd["prdSalDscnDt"] {
//                                    self.itemPrdNmList.append(val1)
//                                    self.itemFncIstNmList.append(val2)
//                                    self.itemRegDateList.append(val3)
//                                    self.itemPrdSalDscnDtList.append(val4)
//                                }
                                
                            }
                            
                            
                        }
                        
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                task2.resume()
                
                
            } catch {
                print(error)
            }
        }
        task.resume()

        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let txt = searchBar.text,
               txt != "" {
                
                switch section {
                case 0: return itemPrdNmList.count
                default:return 0
                }
        } else {
            switch section {
            case 0: return bank.count
            case 1: return nonBank.count
            case 2: return ivmCom.count
            default:return 0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let txt = searchBar.text,
            txt != "" {
                switch section {
                case 0: return "검색 결과"
                default:return ""
                }
        } else {
            switch section {
            case 0: return "은행"
            case 1: return "비은행"
            case 2: return "증권회사"
            default:return ""
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "bank", for: indexPath)
        
        if let txt = searchBar.text,
               txt != "" {
                
                if indexPath.section == 0 {
                    cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
                    
                    let prdNm = cell.viewWithTag(41) as? UILabel
                    let fncIstNm = cell.viewWithTag(42) as? UILabel
//                    let rgDt = cell.viewWithTag(43) as? UILabel
                    let dsDt = cell.viewWithTag(44) as? UILabel
                    
                    prdNm?.text = itemPrdNmList[indexPath.row]
                    fncIstNm?.text = itemFncIstNmList[indexPath.row]
//                    rgDt?.text = itemRegDateList[indexPath.row]
                    dsDt?.text = "마감여부 : " + itemPrdSalDscnDtList[indexPath.row]
                    
//                  lbl?.text = bank[indexPath.row]
                }
                
                btnPrev.isHidden = false
                btnPrev.isEnabled = false
                btnNext.isHidden = false
                
        } else {
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "bank", for: indexPath)
                let lbl = cell.viewWithTag(11) as? UILabel
                lbl?.text = bank[indexPath.row]
            } else if indexPath.section == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "nonBank", for: indexPath)
                let lbl = cell.viewWithTag(21) as? UILabel
                lbl?.text = nonBank[indexPath.row]
            } else if indexPath.section == 2 {
                cell = tableView.dequeueReusableCell(withIdentifier: "ivmCom", for: indexPath)
                let lbl = cell.viewWithTag(31) as? UILabel
                lbl?.text = ivmCom[indexPath.row]
            }
            btnPrev.isHidden = true
            btnNext.isHidden = true
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FinTableViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        search(searchBar.text)
        searchBar.resignFirstResponder()
    }
}
