//
//  DetailViewController.swift
//  BookFinderWithCodable_home
//
//  Created by sy on 10/24/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var strURL:String?  // Segue로 받아와야함
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let strURL,
              let url = URL(string: strURL)
        else { return }

        
        let request = URLRequest(url: url)
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
