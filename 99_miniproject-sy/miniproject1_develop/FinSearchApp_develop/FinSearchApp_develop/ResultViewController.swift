// File Name : TViewController.swift
// Auther    : sy
// Date      : 10/9/24

import UIKit

class ResultViewController: UITableViewController {
    /** 공공데이터 키 필요 */
    let encodingKey = "ajPIwR0zyEoj4FwhiDbwL1Ijize9Mmic%2FdSuIZnAZ73RW2kJ6%2F%2FHXWOWZkvADX6GKEtgwCejQ2KL0fPAnhLSbA%3D%3D"
    
    
    /** Segue 로 넘어온 데이터   */
    var selectedCompany:String?
    var searchBarKeyword:String?
    var pageNo = 1 {
        didSet {
            btnPrev.isEnabled = pageNo > 1
            
            if let totalCount,
               (totalCount/(pageNo*10)) == 0 {
                isEnd = true
                btnNext.isEnabled = false
            } else {
                isEnd = false
            }
        }
    }
    
    /** API 사용, 결과 데이터 */
    var query:String?
    var companyList:[[String:String]]?
    var companyNmList:[String] = []
    
    var itemList:[[String:String]]?
    var itemPrdNmList:[String] = []
    var itemFncIstNmList:[String] = []
    var itemRegDateList:[String] = []
    var itemPrdSalDscnDtList:[String] = []

    var itemCount:Int?
    var totalCount:Int?
    var isEnd:Bool = false
    
    /** Paging Loading Image */
//    lazy var cache: NSCache<AnyObject, UIImage> = NSCache()
    
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var btnPageReadOnly: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ResultView 도착")
        
        /** Section Header Custom */
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")

        /** Setting query by SelectedRow or SearchBar  */
        if let selectedCompany {
            query = selectedCompany
        } else {
            query = searchBarKeyword
        }
        
        btnPrev.isEnabled = false
        btnNext.isEnabled = false
        isEnd = false
        
        search2(query, pageNo:pageNo)
    }
    
    

    
    
    
    
    
    
    func search2(_ query:String?, pageNo:Int) {
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

// 맨처음에 JSON해올 때 이미 as? [String:[String:Any]] 타입으로 지정했기 때문에
// list.keys = ["header", "rows", "pageNo", "item", "totalCount", "numOfRows"]들은 String이지만
// key "item":String의 value:Any 타입이다.
//    ㄴ "item" : [ [], [], [] ] 배열 형태가 아닌
//    ㄴ "item" : "item": <__NSArrayI 0x10680ce00>({}, {}, {} ... )
// 그래서 list["item"] = Any인 상태라 또 as? 타입 지정을 해줘야함.
                
                print("------------------------------")
                print(list)
//                print(list.keys)
//                print(item)
                print("------------------------------")
                
                self.companyList = item
                for comNm in item {
                    if let nm = comNm["fncIstNm"]{
                        self.companyNmList.append(nm)
                    }
                }
                
                
                /** 2.  금융회사별 보호대상 금융상품 */
                if let hangulComNm = query {
                    /** 검색어가 금융사 명에 포함되어있으면 금융사명 파라미터 사용 / 없으면 상품명 파라미터 사용 */
                    for nm in self.companyNmList {
                        if nm.contains(hangulComNm) {
                            endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getProductList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=\(pageNo)&numOfRows=10&fncIstNm=\(searchKeyword)"
                            break
                        } else {
                            endPoint = "http://apis.data.go.kr/B190017/service/GetInsuredProductService202008/getProductList202008?serviceKey=\(self.encodingKey)&resultType=json&pageNo=\(pageNo)&numOfRows=10&prdNm=\(searchKeyword)"
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
                        
                        self.itemPrdNmList.removeAll()
                        self.itemFncIstNmList.removeAll()
                        self.itemPrdSalDscnDtList.removeAll()
                        
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
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()

                            
                            if totalCount < 10 {
                                self.btnPrev.isEnabled = false
                                self.btnNext.isEnabled = false
                            } else if totalCount > 10, !self.isEnd {
                                self.btnNext.isEnabled = true
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
        }
        
        /** Paging Loading Image */
//        if (cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil) {
//            /// 해당 row에 해당되는 부분이 캐시에 존재하는 경우
//            cell.imageView?.image = cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject)
//        } else {
//            /// 해당 row에 해당되는 부분이 캐시에 존재하지 않는 경우
//        }
        
        
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        /** Section Header Custom */
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        header?.textLabel?.numberOfLines = 2
        
        if let totalCount,
           let query {
            header?.textLabel?.text = "'\(query)' 검색 결과 : 총 \(totalCount)개 (\(pageNo)페이지)"
            
        }
        header?.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        header?.textLabel?.textColor = .systemBlue
        
        
        /** shadow custom */
//        header?.layer.shadowColor = UIColor.white.cgColor
//        header?.layer.masksToBounds = false
//        header?.layer.shadowOffset = CGSize(width: 0, height: 4)
//        header?.layer.shadowRadius = 5
//        header?.layer.shadowOpacity = 0.5
        
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
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
    
    

    @IBAction func actPrev(_ sender: Any) {
        pageNo -= 1
        search2(query, pageNo:pageNo)
    }
    
    
    @IBAction func actNext(_ sender: Any) {
        pageNo += 1
        search2(query, pageNo:pageNo)
    }
    
}





/** API Output 불필요 문자열 정규식 정리 코드 */
extension String {
    var stripHTML : String {
        return self.replacingOccurrences(of: "<[^>]>", with: "", options: .regularExpression)
    }
    
    
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else { return nil }
            
            let attributed =
            try NSAttributedString(data: data, options: [.documentType:NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch  {
            return nil
        }
    }
}
