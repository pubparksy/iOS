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
    var vItemKey = ["title","author","play_time","url","datetime"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        search("Jazz")
    }

    func search(_ query:String) {
        let endPoint1 = "https://openapi.naver.com/v1/search/webkr.json?query=\(query)&display=3"
        let endPoint2 = "https://openapi.naver.com/v1/search/image?query=\(query)&display=3"
        let endPoint3 = "https://dapi.kakao.com/v2/search/vclip?query=\(query)&size=3"
        
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
                      let webList = root["items"] as? [[String:Any]]
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
                
                print("[다음 영상 검색]")
                for web in webList {
                    guard let wTitle = web[self.wItemKey[0]],
                          let wLink  = web[self.wItemKey[1]],
                          let wDesc  = web[self.wItemKey[2]]
                    else { return }
                    print(wTitle)
                    print(wLink)
                    print(wDesc)
                    print()
                }
                print()
                
                
                
                
                let task2 = session.dataTask(with: request2) { data, response, error in
                    if let error { print("\(error) 발생"); return }
                    guard let data else { return }
                    
                    do {
                        guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                             let imgList = root["items"] as? [[String:Any]]
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
                        
                        
                        print("[네이버 이미지 검색]")
                        for img in imgList {
                            guard let iTitle = img[self.iItemKey[0]],
                                  let iLink  = img[self.iItemKey[1]],
                                  let iDesc  = img[self.iItemKey[2]]
                            else { return }
                            print(iTitle)
                            print(iLink)
                            print(iDesc)
                            print()
                        }
                        print()
                        
                        let task3 = session.dataTask(with: request3) { data, response, error in
                            if let error { print("\(error) 발생"); return }
                            guard let data else { return }
                            
                            do {
                                guard let root     = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                                     let vdList = root["documents"] as? [[String:Any]]
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
                                
                                
                                print("[다음 영상 검색]")
                                for vd in vdList {
                                    guard let vTitle    = vd[self.vItemKey[0]],
                                          let vAuthor   = vd[self.vItemKey[1]],
                                          let vPlayTime = vd[self.vItemKey[2]],
                                          let vUrl      = vd[self.vItemKey[3]],
                                          let vDateTime = vd[self.vItemKey[4]]
                                    else { return }
                                    print(vTitle)
                                    print(vAuthor)
                                    print(vPlayTime)
                                    print(vUrl)
                                    print(vDateTime)
                                    print()
                                }
                                print()
                                
                                
                                
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
}
