//
//  DetailViewController.swift
//  FinSearchApp
//
//  Created by 박소영 on 9/9/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    let naverClientId = "7ykDmRQ0DL_hn59rT_nR"
    let naverClientSecret = "h5rpebbXjV"
    
    @IBOutlet weak var webView: WKWebView!
    
    var itemPrdNm:String?
    var itemFncIstNm:String?
    
    var detailList:[String:[String:String]]?
    var detailLink:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let itemPrdNm ,let itemFncIstNm else {return}
        let query = itemFncIstNm + " " + itemPrdNm
        search3(query)
//        let endPoint = "https://openapi.naver.com/v1/search/webkr.json?query=\(query)"
//        guard let strURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//              let url = URL(string: strURL)
//        else { return }
//        
//        
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue(naverClientId, forHTTPHeaderField: "X-Naver-Client-Id")
//        request.addValue(naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
//        
//        webView.load(request)
        
    }
    

    
    
    func search3(_ query:String?) {
        guard let query else { return }
        let endPoint = "https://openapi.naver.com/v1/search/webkr.json?query=\(query)"
        guard let strURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: strURL)
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(naverClientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let session = URLSession.shared
        
        
        var resultUrl = ""
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error { print("\(error) 발생"); return }
            guard let data else { return }
            
            
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String:String]]
                    , let detailList = root["items"] as? [String:[String:String]]
                else { return }
                print(detailList)
                self.detailList = detailList
                
//                for detail in detailList {
//                    if let title = detail["title"] ,
//                       let link  = detail["url"],
//                       let desc  = detail["description"] {
//                        if !link.contains("") || !link.contains("") || !link.contains("") {
//                            resultUrl = link
//                            break
//                        }
//                    }
//                }
                
                
                
                
            } catch {
                print(error)
            }
        }
        task.resume()

        
        guard let url = URL(string: resultUrl) else { return }
        request = URLRequest(url: url)
        
        webView.load(request)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
