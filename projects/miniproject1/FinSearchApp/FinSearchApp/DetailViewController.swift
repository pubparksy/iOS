//
//  DetailViewController.swift
//  FinSearchApp
//
//  Created by 박소영 on 9/9/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
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
        
    }
    

    
    
    func search3(_ query:String?) {
        guard let query else { return }
        let endPoint = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=\(query)"
        guard let strURL = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: strURL)
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
