//
//  BookTableViewController.swift
//  BookFinderWithCodable
//
//  Created by sy on 10/22/24.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    let apiKey = "KakaoAK d4aa8e5a1a4ee4636ae50f648c1cbbc1"
    var books:[Book]?
    var isEnd:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search(query: "한강", page: 1)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }


    func search(query:String, page:Int) {
        let str = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)" // 책 검색 api url

        guard let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: strURL)
        else {return}
        
        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession.shared // SingleTon
        
        let task = session.dataTask(with: request) { data, response, error in // data, response 둘다 옵셔널
            guard let data,
                  let master = try? JSONDecoder().decode(Master.self, from: data)
            else { return }
//            print(master)
            self.books = master.books
            self.isEnd = master.meta.isEnd
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath)
            guard let book = books?[indexPath.row] else { return cell } // Non-void function should return a value < 함수 자체에 리턴타입이 있기 때문에 오류발생
            let imageView = cell.viewWithTag(1) as? UIImageView
            
            let lblTitle  = cell.viewWithTag(2) as? UILabel
            lblTitle?.text = book.title
            
            let lblAuthors = cell.viewWithTag(3) as? UILabel
            let authors = book.authors
            lblAuthors?.text = authors.joined(separator: ", ")
            
            let thumbnail = book.thumbnail
            if let url = URL(string: thumbnail) {
                let request = URLRequest(url:url)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data {
                        DispatchQueue.main.async {
                            imageView?.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
            return cell
    }
    
    
    
    
 }
