//
//  View2Controller.swift
//  WebNativeCom_study
//
//  Created by sy on 10/9/24.
//

import UIKit
import WebKit

class View2Controller: UIViewController {

    var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webViewConfig = WKWebViewConfiguration()
        /**
        var userContent = WKUserContentController()
        webViewConfig.userContentController = userContent
         */
        let frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: view.frame.height/3 * 2))
        webView =  WKWebView(frame: frame, configuration: webViewConfig)
        
        // 여기서 언랩해도 됨
        guard let webView else { return }
        // view를 보이게 하려면 루트 뷰에 포함시키기
        view.addSubview(webView)

        
        // http,request 설정
        guard let url = URL(string: "http://127.0.0.1:8082") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @IBAction func action1(_ sender: Any) {
        webView?.evaluateJavaScript("call_func1()") // swift > js의 call_func1() 호출 // 상단에 textInner < call_func1
    }
    
    @IBAction func action2(_ sender: Any) {
        let name = "에스파"
        webView?.evaluateJavaScript("call_func2('\(name)')")
    }
    
    @IBAction func action3(_ sender: Any) {
        // swift > js의 call_func3(info) 호출 // 상단에 textInner < 에스파 띄우고
           let info = ["phone":"010-1111-1111", "email":"a@a.com","name":"카리나","gender":"male"]
           
           do {
               // 2 기종 간에 데이터 넘길 때 타입이 Data인 타입으로 주고 받는다
               let infoData:Data = try JSONSerialization.data(withJSONObject: info)      // (1) 보낼 데이터
               // 에러가 나오면 요청한 곳으로 돌려보냄?
               // throw 나오면 꼭 try catch를 해줘야함


   //            let encodedData = String(data: infoData, encoding: .utf8) // optional 상태
               guard let encodedData = String(data:infoData, encoding: .utf8) else { return } // (2)정렬화된걸? 다시 문자열로 바꿈
               

               // Any가 없으면     , Any 가 있으면 error = Nil
               // completionHandler = 써도안써도 되기 때문에 옵셔널 // js의 call_func3(info) > swift // 수정된 obj를 return
               webView?.evaluateJavaScript("call_func3('\(encodedData)')", completionHandler: { result, error in // result, error 둘다 옵셔널
                   if let error {
                       return  // error 가 있으면 멈추도록
                   }
                   guard let info = result as? [String:String] else  { return } // js의 return obj = result = info
                   print(info)
               })    // (3)보냈음!!
               
           } catch {
               print("에러발생")
           }

    }
    
}
