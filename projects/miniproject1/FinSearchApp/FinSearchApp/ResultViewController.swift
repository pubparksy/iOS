//
//  DetailViewController.swift
//  FinSearchApp
//
//  Created by soyoung Park on 9/8/24.
//

import UIKit

class ResultViewController: UITableViewController {
    /** 공공데이터 키 필요 */
    let encodingKey = ""
    
    
    var companyList:[[String:String]]?
    var companyNmList:[String] = []
    
    var itemList:[[String:String]]?
    var itemPrdNmList:[String] = []
    var itemFncIstNmList:[String] = []
    var itemRegDateList:[String] = []
    var itemPrdSalDscnDtList:[String] = []
    
    
    var company:String?  // Segue로 받아와야함
    var searchBarKeyword:String?
    var itemCount:Int?
    var totalCount:Int?
    
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        self.btnPrev.isHidden = true
        self.btnNext.isHidden = true
        print("뷰는 넘어옴!")
        
        if let company {
            search2(company)
        } else {
            search2(searchBarKeyword)
        }
        
    }
    
    

    
    
    
    
    
    
    func search2(_ query:String?) {
        guard let searchKeyword = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
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
                
                
                /** 2.  금융회사별 보호대상 금융상품 */
                if let hangulComNm = query {
                    
                    for nm in self.companyNmList {
                        if nm.contains(hangulComNm) {
                            endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getProductList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=1&numOfRows=100&fncIstNm=\(searchKeyword)"
                            break
                        } else {
                            endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getProductList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=1&numOfRows=100&prdNm=\(searchKeyword)"
                        }
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
                            , let totalCount = list["totalCount"] as? Int
                        else { return }
                        
                        for prd in item {
                            
                            if let val1 = prd["prdNm"],
                               let val2 = prd["fncIstNm"] {
                                self.itemPrdNmList.append(val1)
                                self.itemFncIstNmList.append(val2)
                            }
                            
                            if let dt = prd["prdSalDscnDt"],
                               dt == "" {
                                self.itemPrdSalDscnDtList.append("판매중")
                            } else {
                                self.itemPrdSalDscnDtList.append("판매종료")
                            }
                            
                        }
                        
                        
                        self.totalCount = totalCount
                        self.itemCount = self.itemPrdNmList.count
//                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            if totalCount > 0 {
                                self.btnPrev.isHidden = false
                                self.btnPrev.isEnabled = false
                                self.btnNext.isHidden = false
                            }
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
        1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemPrdNmList.count // main에서 넘어온 데이터 갯수만큼 표시
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath)
        
        if  let itemCount,
            itemCount > 0 {
            let prdNm = cell.viewWithTag(31) as? UILabel
            let fncIstNm = cell.viewWithTag(32) as? UILabel
            let dsDt = cell.viewWithTag(33) as? UILabel
            
            prdNm?.text = itemPrdNmList[indexPath.row]
            fncIstNm?.text = itemFncIstNmList[indexPath.row]
            dsDt?.text = itemPrdSalDscnDtList[indexPath.row]
            if itemPrdSalDscnDtList[indexPath.row] == "판매종료" {
                dsDt?.textColor = .gray
            } else {
                dsDt?.textColor = .black
            }
        } else if itemCount == 0 {
            let img = cell.viewWithTag(34) as? UIImageView
            img?.image = nil
            
            let prdNm = cell.viewWithTag(31) as? UILabel
            prdNm?.text = "검색 결과 없음"
            prdNm?.textAlignment = .center
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        
        if let totalCount {
            if let company {
                header?.textLabel?.text = "'\(company)' 검색 결과 : 총 \(totalCount)개"
            } else if let searchBarKeyword {
                header?.textLabel?.text = "'\(searchBarKeyword)' 검색 결과 : 총 \(totalCount)개"
            }
        }
        header?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header?.textLabel?.textColor = .systemBlue
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            detailVC?.itemPrdNm = itemPrdNmList[indexPath.row]
            detailVC?.itemFncIstNm = itemFncIstNmList[indexPath.row]
        }
    }
    
    

}
