//
//  FinTableViewController.swift
//  FinSearchApp
//
//  Created by soyoung Park on 9/8/24.
//

import UIKit

class FinTableViewController: UITableViewController {
    /** 공공데이터 키 필요 */
    let encodingKey = ""
    let decodingKey = ""

    
    /** 현시점 중앙은행 [국내사이트 - 금융기관] 명시 기준 .  초기화면  section별 구분 후 선택 시 관련 기관 별 상품 조회하도록 DetailView? */
    let bank = ["KEB하나은행", "SC제일은행", "국민은행", "신한은행", "외환은행", "우리은행", "한국시티은행","경남은행", "광주은행", "대구은행", "부산은행", "전북은행", "제주은행", "기업은행", "농협", "수협", "한국산업은행", "한국수출입은행"]
    let nonBank = ["우리종합금융", "SBI저축은행", "애큐온저축은행", "키움YES저축은행", "푸른저축은행", "DB자산운용", "교보악사자산운용", "대신투자신탁운용", "신한BNP파리바자산운용", "유진자산운용", "한화자산운용", "우체국예금보험"]
    let ivmCom = ["KB증권", "NH투자증권", "SK증권", "골든브릿지투자증권", "교보증권", "대신증권", "미래에셋대우", "미래에셋증권", "부국증권", "삼성증권", "신영증권", "유진투자증권", "유화증권", "키움증권", "한국투자증권", "한양증권", "한화증권"]
    
    
    var itemList:[[String:String]]?
    var companyList:[[String:String]]?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search("적금")
    }

    // MARK: - Table view data source
    func search(_ query:String) {
        var encodedQ = ""
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            encodedQ = encodedQuery
        }
        
        
        var endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getProductList202008?serviceKey=\(encodingKey)&resultType=json&pageNo=1&numOfRows=100&fncIstNm=&prdNm=\(encodedQ)"
        guard let url    = URL(string: endPoint) else { return } // nil이면 더이상 진행이 의미없음. 멈춰.
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error { print("\(error) 발생"); return }
            guard let data else { return }
            
            
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String:Any]]
                    , let list = root["getProductList"]
                    , let item = list["item"] as? [[String:String]]
                else { return }
                self.itemList = item
                print(self.itemList!)
                
                
                
                print()
                print()
                print()
                endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getCompanyList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=1&numOfRows=284"
                
                guard let url = URL(string: endPoint) else { return }
                request = URLRequest(url: url)
                
                let task2 = session.dataTask(with: request) { data, response, error in
                    if let error { print("\(error) 발생"); return }
                    guard let data else { return }
                    
                    
                    do {
                        guard let root2 = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String:Any]]
                            , let list = root2["getCompanyList"]
                            , let item = list["item"] as? [[String:String]]
                        else { return }
                        self.companyList = item
//                        print(self.companyList!)
                        
//                        for i in item {
//                            if let fncNm = i["fncIstNm"] {
//                                print(fncNm)
//                            }
//                        }
                        
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
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "bank", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "nonBank", for: indexPath)
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
