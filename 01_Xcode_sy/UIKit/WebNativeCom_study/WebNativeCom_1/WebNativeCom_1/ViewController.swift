//
//  ViewController.swift
//  WebNativeCom_study
//
//  Created by sy on 10/9/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = URL(string: "http://127.0.0.1:8081") else { return }
        let request = URLRequest(url: url)
        
        guard let webView else { return  }
        
        webView.load(request)
        
        
//        let webViewConfig = WKWebViewConfiguration()
//        var userContent = WKUserContentController() // 얘를 만들어서 세팅하고 > webViewConfig에 넣어야함. 이게 delegate 패턴ㄴ
//        userContent.add(self, name:"SendMessage") // js의 func send1()
//        // (param1: handler가 들어왔을 때 어디서 처리할 거냐, name:메시지이름)
//        // 근데 여기의 self는 delegate 개념이라 fix하면 여기에 추가되지만 앞응로 extension 쓰기로 했으니까 ㄱㄱ
//        // js의 webkit.messageHandlers."SendMessage".postMessage({}); 중간에 SendMessage
//        
//        userContent.add(self, name:"SayHello") // js의 func send2()
//        // js의 webkit.messageHandlers."SayHello".postMessage('아델!!'); 중간에 SayHello
//        
//        userContent.add(self, name:"SetUser") // 원랜 이렇지만..  // js의 func send3()
//        // js의 webkit.messageHandlers."SetUser".postMessage(info); 중간에 SetUser
//     
////        let handler = MessageHandler()
////        userContent.add(handler, name: "SetUser")
////      다른애들은 self지만, 들어오는 메시지가 self 하나에 다할 순 없고..? 성격에 따라서 다르게 처리해야하니까..? 일 해줄 사람을 나눠둠
//        
//        
//        
//        // 여태까진 1개의 객체에서 처리였지만 메시지에 따라서 뭘 처리할 지 달라지는거임
//        
//        webViewConfig.userContentController = userContent
//        //-----------------여기까지가 웹뷰 만들때 이렇게 만들어달라 완성
//
//        let frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: view.frame.height/3 * 2))
//        
//        
////        var webView =  WKWebView(frame: view.frame,  // 'view'의 프레임에 맞춰서 나온다
////                                 configuration: webViewConfig)
//        
//        webView =  WKWebView(frame: frame,  // 'view'의 프레임에 맞춰서 나온다
//                            configuration: webViewConfig)
//        // 여기서 언랩해도 됨
//        guard let webView else { return  }
//        
//        
//        
//        // view를 보이게 하려면 루트 뷰에 포함시키기
//        view.addSubview(webView)
//        
//        
//        
//        // http,request 설정
//        guard let url = URL(string: "http://127.0.0.1:8080") else { return }
//        let request = URLRequest(url: url)
//        webView.load(request)
//        
//        
//        webView.uiDelegate = self
        
    }


}

