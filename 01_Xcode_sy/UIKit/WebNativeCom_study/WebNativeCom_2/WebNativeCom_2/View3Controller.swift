//
//  View3Controller.swift
//  WebNativeCom_study
//
//  Created by sy on 10/9/24.
//

import UIKit
import WebKit

class View3Controller: UIViewController {

    var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
        guard let url = URL(string: "http://127.0.0.1:8083") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        */
        
        let webViewConfig = WKWebViewConfiguration()
        var userContent = WKUserContentController() // 얘를 만들어서 세팅하고 > webViewConfig에 넣어야함. 이게 delegate 패턴ㄴ
//        userContent.add(self, name:"SendMessage") // js의 func send1()
//        
//        userContent.add(self, name:"SayHello") // js의 func send2()
//        
//        userContent.add(self, name:"SetUser") // 원랜 이렇지만..  // js의 func send3()
     
        webViewConfig.userContentController = userContent
        //-----------------여기까지가 웹뷰 만들때 이렇게 만들어달라 완성

        let frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: view.frame.height/3 * 2))
        
        webView =  WKWebView(frame: frame, configuration: webViewConfig)
        // 여기서 언랩해도 됨
        guard let webView else { return  }
        
        
        
        // view를 보이게 하려면 루트 뷰에 포함시키기
        view.addSubview(webView)
        
        
        
        // http,request 설정
        guard let url = URL(string: "http://127.0.0.1:8083") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
        webView.uiDelegate = self
        
    }

}

// 아래 없으면 App에서 js button을 눌러도 onClick fn 작동 안함
// 아래 extension 쓰고 나면 webView.uiDelegate = self도 꼭 적어줘야함!!!
// 화면 속 button 갯수와 동일? 해야하나?..? 아닌거 같은데...
extension View3Controller: WKUIDelegate {

//  alert 함수 구현
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in // action은 필요없고 바로 실행되게
            completionHandler()// 매개변수를 그대로 호출. 우리가 할 수도 있지만 그거보다 간단해서 사용.
        }
        alert.addAction(action)
        present(alert, animated: true)
    } // 다하면 올라가서 webView.uidelegate = self 먹여줘야함
    
//  confirm 함수 구현
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "확인", style: .default) { _ in // action은 필요없고 바로 실행되게
            completionHandler(true)  // completionHandler: @escaping (Bool) -> Void < js confirm 의 true면 하겠다
            // html의 js에 가면 show_confirm 함수를 찾..는 건 아니고...
            // WebView에서 alert가 띄워지면 그걸 찾아서 인식함.
            // 그때 정보를 전달 받아서 모바일에서 alert를 띄워주는 것
        }
        let actionCancel = UIAlertAction(title: "취소", style: .cancel) { _ in // action은 필요없고 바로 실행되게
            completionHandler(false) // completionHandler: @escaping (Bool) -> Void < false 면 안하겠다
        }
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }

    
// js promt 입력하면 넘기는 함수. 근데 이 web prompt 사용빈도는 적고..(실제로도 적었지 거의 사용 안함). web에서 alert, confirm하는 걸 mobile에서도 할 수 있게 해주는 함수
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
//        defaultText = placeholder
        
        
        let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alert.addTextField { textField in // 추가하려는 텍스트가 있으면 여기서 추가. 배열 타입
            textField.placeholder = defaultText
        }
        //----------- 여기까지가   alert에 텍스트 넣은것
        
        
        
        // action start
        let action = UIAlertAction(title: "입력하시오", style: .default) { _ in
//            completionHandler 를 호출해야함
//            let text = alert.textFields?[0] // textFields[0] 유무를 모르니까 옵셔널
            
            
//          값을 입력 안하고 그냥 확인 눌렀는지 체크하는거
            if let text1 = alert.textFields?[0] {
                // 입력했으면 입력한거로 넣고
//              let text = text1.text // 유효성 체크 해야함
                let text = text1.text == "" ? defaultText : text1.text
                completionHandler(text)
            } else {
                // 입력 안했으면 기본값을 넣도록
                completionHandler(defaultText)
            }
        } // action end
    
        
        alert.addAction(action)
        
        
        present(alert, animated: true)
        
    }
    
    
}
