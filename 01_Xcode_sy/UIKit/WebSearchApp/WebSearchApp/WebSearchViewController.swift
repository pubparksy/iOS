//
//  WebSearchViewController.swift
//  WebSearchApp
//
//  Created by soyoung Park on 9/7/24.
//

import UIKit

class WebSearchViewController: UITableViewController {
    /** open API Key Global Var 로 하단 입력 필요*/
    
    var webList:[[String:Any]]?
    var imgList:[[String:Any]]?
    var vdList:[[String:Any]]?
    
    var wItemKey = ["title","link","description"]
    var iItemKey = ["title","link","thumbnail","sizeheight","sizewidth"]
    var vItemKey = ["title","author","play_time","datetime","url","thumbnail"]

    var page = 1 {
        didSet {
            search(searchBar.text, page: page)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    func search(_ query:String?, page:Int) {
        guard let query else { return }
        
        let endPoint1 = "https://openapi.naver.com/v1/search/webkr.json?query=\(query)&display=10"
        let endPoint2 = "https://openapi.naver.com/v1/search/image?query=\(query)&display=10"
        let endPoint3 = "https://dapi.kakao.com/v2/search/vclip?query=\(query)&size=10"
        
//      let url = URL(string: endPoint)
        guard let url1 = URL(string: endPoint1) else { return } // nil이면 더이상 진행이 의미없음. 멈춰.
        guard let url2 = URL(string: endPoint2) else { return } // nil이면 더이상 진행이 의미없음. 멈춰.
        guard let url3 = URL(string: endPoint3) else { return } // nil이면 더이상 진행이 의미없음. 멈춰.
        
        var request1 = URLRequest(url: url1)
        var request2 = URLRequest(url: url2)
        var request3 = URLRequest(url: url3)
        request1.addValue(naverCI, forHTTPHeaderField: naverH[0])
        request1.addValue(naverCS, forHTTPHeaderField: naverH[1])
        request1.httpMethod = "GET"
        request2.addValue(naverCI, forHTTPHeaderField: naverH[0])
        request2.addValue(naverCS, forHTTPHeaderField: naverH[1])
        request2.httpMethod = "GET"
        request3.addValue(apiKey, forHTTPHeaderField: "Authorization")
        request3.httpMethod = "GET"
        
        
        let session = URLSession.shared
        
        let task1 = session.dataTask(with: request1) { data, response, error in
            if let error { print("\(error) 발생"); return }
            guard let data else { return }
            
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                      let wList = root["items"] as? [[String:Any]]
                                else { return }
//                print(webList)
//                print(webList[0]["title"] as? String)
                
//                guard let wTitle = webList[0][self.wItemKey[0]],
//                      let wLink  = webList[0][self.wItemKey[1]],
//                      let wDesc  = webList[0][self.wItemKey[2]]
//                else { return }
//                print("[네이버 웹 검색]")
//                print(wTitle)
//                print(wLink)
//                print(wDesc)
//                print()
                
//                print("[다음 영상 검색]")
//                for web in webList {
//                    guard let wTitle = web[self.wItemKey[0]],
//                          let wLink  = web[self.wItemKey[1]],
//                          let wDesc  = web[self.wItemKey[2]]
//                    else { return }
//                    print(wTitle)
//                    print(wLink)
//                    print(wDesc)
//                    print()
//                }
//                print()
                
                self.webList = wList
                
                
                let task2 = session.dataTask(with: request2) { data, response, error in
                    if let error { print("\(error) 발생"); return }
                    guard let data else { return }
                    
                    do {
                        guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                             let iList = root["items"] as? [[String:Any]]
                                        else { return }
//                        print(items)
//                        print()
//                        guard let iTitle = imgList[0][self.iItemKey[0]],
//                              let iLink  = imgList[0][self.iItemKey[1]],
//                              let iDesc  = imgList[0][self.iItemKey[2]]
//                        else { return }
//                        print("[네이버 이미지 검색]")
//                        print(iTitle)
//                        print(iLink)
//                        print(iDesc)
//                        print()
                        
                        
//                        print("[네이버 이미지 검색]")
//                        for img in imgList {
//                            guard let iTitle = img[self.iItemKey[0]],
//                                  let iLink  = img[self.iItemKey[1]],
//                                  let iDesc  = img[self.iItemKey[2]]
//                            else { return }
//                            print(iTitle)
//                            print(iLink)
//                            print(iDesc)
//                            print()
//                        }
//                        print()
                        self.imgList = iList
                        
                        let task3 = session.dataTask(with: request3) { data, response, error in
                            if let error { print("\(error) 발생"); return }
                            guard let data else { return }
                            
                            do {
                                guard let root     = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                                     let vList = root["documents"] as? [[String:Any]]
                                                else { return }
//                                print(vdList)
                                
//                                guard let vTitle    = vdList[0][self.vItemKey[0]],
//                                      let vAuthor   = vdList[0][self.vItemKey[1]],
//                                      let vPlayTime = vdList[0][self.vItemKey[2]],
//                                      let vUrl      = vdList[0][self.vItemKey[3]],
//                                      let vDateTime = vdList[0][self.vItemKey[4]]
//                                else { return }
//                                print("[다음 영상 검색]")
//                                print(vTitle)
//                                print(vAuthor)
//                                print(vPlayTime)
//                                print(vUrl)
//                                print(vDateTime)
//                                print()
                                
                                
//                                print("[다음 영상 검색]")
//                                for vd in vdList {
//                                    guard let vTitle    = vd[self.vItemKey[0]],
//                                          let vAuthor   = vd[self.vItemKey[1]],
//                                          let vPlayTime = vd[self.vItemKey[2]],
//                                          let vUrl      = vd[self.vItemKey[3]],
//                                          let vDateTime = vd[self.vItemKey[4]]
//                                    else { return }
//                                    print(vTitle)
//                                    print(vAuthor)
//                                    print(vPlayTime)
//                                    print(vUrl)
//                                    print(vDateTime)
//                                    print()
//                                }
//                                print()
                                
                                self.vdList = vList
                                
                                
                                /** 테이블 구조 설정 했는데도 안나오면 이거 안한 것 */
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                
                            } catch {
                                print(error)
                            }
                        }
                        task3.resume()
                        
                        
                        
                    } catch {
                        print(error)
                    }
                }
                task2.resume()
                
                
                
            } catch {
                print(error)
            }
        }
        task1.resume()
        
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
//        print("numberOfSections")
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return webList?.count ?? 0
            case 1: return imgList?.count ?? 0
            case 2: return vdList?.count ?? 0
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "web", for: indexPath)
            guard let web = webList?[indexPath.row] else { return cell }
            
            let wTitle = cell.viewWithTag(11) as? UILabel
            if let title = web[self.wItemKey[0]] as? String {
                wTitle?.text = title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
            }
            
            
            
            
            let wDesc = cell.viewWithTag(12) as? UILabel
            wDesc?.text = web[self.wItemKey[1]] as? String
            
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "img", for: indexPath)
            guard let img = imgList?[indexPath.row] else { return cell }
            
            let iTitle = cell.viewWithTag(22) as? UILabel
            iTitle?.text = img[self.iItemKey[0]] as? String
            let iDesc  = cell.viewWithTag(23) as? UILabel
            iDesc?.text = img[self.iItemKey[1]] as? String
            
            let iImage = cell.viewWithTag(21) as? UIImageView
            // 사진 데이터 값이 url로 되어있으니까, 그 url에 1번 더 Session 연결해서 이미지를 가져와야함
            if let iLink = img[self.iItemKey[1]] as? String {
                if let url = URL(string: iLink) {
                    let request = URLRequest(url: url)
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let data {
                            DispatchQueue.main.sync {
                                iImage?.image = UIImage(data: data)
                            }
                        }
                    }
                    task.resume()
                    
                }
            }
            
        } else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "vd", for: indexPath)
            guard let vd = vdList?[indexPath.row] else { return cell }
            
            let vTitle = cell.viewWithTag(32) as? UILabel
            vTitle?.text = vd[self.vItemKey[0]] as? String
            
            let vDate = cell.viewWithTag(33) as? UILabel
            if let date = vd[self.vItemKey[3]] as? String {
                vDate?.text = String(date[date.startIndex ..< date.index(date.startIndex, offsetBy: 10)])
            }
            
            let vAuthor = cell.viewWithTag(34) as? UILabel
            vAuthor?.text = vd[self.vItemKey[1]] as? String
            let vPlayTime = cell.viewWithTag(35) as? UILabel
            var time = ""
            if let playTime = vd[self.vItemKey[2]] as? Int {
                if playTime/3600 > 0 {
                    time = String(playTime/3600) + ":"
                    if (playTime%3600)/60 > 0 {
                        time = time + String((playTime%3600)/60) + ":"
                        time = time + String((playTime%3600)%60)
                    } else {
                        time = time + String((playTime%3600)%60)
                    }
                } else {
                    if (playTime%3600)/60 > 1 {
                        time = time + String((playTime%3600)/60) + ":"
                        time = time + String((playTime%3600)%60)
                    } else {
                        time = time + String(playTime)
                    }
                }
            }
            vPlayTime?.text = time
            
            
            let vImage = cell.viewWithTag(31) as? UIImageView
            // 사진 데이터 값이 url로 되어있으니까, 그 url에 1번 더 Session 연결해서 이미지를 가져와야함
            if let vThumbnail = vd[self.vItemKey[5]] as? String {
                if let url = URL(string: vThumbnail) {
                    let request = URLRequest(url: url)
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        if let data {
                            DispatchQueue.main.sync {
                                vImage?.image = UIImage(data: data)
                            }
                        }
                    }
                    task.resume()
                }
            }
            
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "Naver Web"
            case 1: return "Naver Image"
            case 2: return "Kakao Video"
        default: return ""
        }
    }
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0: return 60
            case 1: return 100
            case 2: return 260
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detailVC
//    }
    
}

extension WebSearchViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.resignFirstResponder()
    }
}
