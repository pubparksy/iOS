//
//  DetailViewController.swift
//  FinSearchApp
//
//  Created by soyoung Park on 9/8/24.
//

import UIKit

class ResultViewController: UITableViewController {
    /** 공공데이터 키 필요 */
    let encodingKey = "lzyJeCYYMKxGYIApLDSl0ALEqxtoOlDd6ksRAPMZ49UYFq5vIAfGYOcURSWKp0zy9DX18dtHAL28MVbL64Dvgw%3D%3D"
    
    
    var companyList:[[String:String]]?
    var companyNmList:[String] = []
    
    var itemList:[[String:String]]?
    var itemPrdNmList:[String] = []
    var itemFncIstNmList:[String] = []
    var itemRegDateList:[String] = []
    var itemPrdSalDscnDtList:[String] = []
    
    
    var company:String?  // Segue로 받아와야함
    var searchBarKeyword:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(company)
        print(searchBarKeyword)
        print("뷰는 넘어옴!")
        
        if let company {
            search2(company)
        } else {
            search2(searchBarKeyword)
        }
        
    }
    
    

    
    
    
    
    
    
    func search2(_ query:String?) {
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
                                       let val2 = prd["fncIstNm"] {
                                        self.itemPrdNmList.append(val1)
                                        self.itemFncIstNmList.append(val2)
                                        self.itemPrdSalDscnDtList.append("진행중")
                                    }
                                    
                            } else {
                                // 판매중단 상품까지 담으려면 여기
//                                if let val1 = prd["prdNm"],
//                                   let val2 = prd["fncIstNm"],
//                                   let val4 = prd["prdSalDscnDt"] {
//                                    self.itemPrdNmList.append(val1)
//                                    self.itemFncIstNmList.append(val2)
//                                    self.itemPrdSalDscnDtList.append(val4)
//                                }
                                
                            }
                            
                            
                        }
                        
//                        print(self.itemPrdNmList)
//                        print(self.itemFncIstNmList)
//                        print(self.itemPrdSalDscnDtList)
//                        
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
        1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemPrdNmList.count // main에서 넘어온 데이터 갯수만큼 표시
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath)
        
        let prdNm = cell.viewWithTag(31) as? UILabel
        let fncIstNm = cell.viewWithTag(32) as? UILabel
        let dsDt = cell.viewWithTag(33) as? UILabel
        
        prdNm?.text = itemPrdNmList[indexPath.row]
        fncIstNm?.text = itemFncIstNmList[indexPath.row]
        dsDt?.text = "판매중"
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "검색 결과"
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
