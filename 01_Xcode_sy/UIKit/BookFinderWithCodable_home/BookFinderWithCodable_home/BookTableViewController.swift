//
//  BookTableViewController.swift
//  BookFinderWithCodable
//
//  Created by sy on 10/22/24.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    var books:[Book]?
    var isEnd:Bool?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var page = 1  {// 검색은 언제나 검색결과를 새로 띄워주는거니까 1로 지정
        didSet {
            search(searchBar.text, page: 1)
        } // 프로퍼티 옵저버
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        search("한강", page: 1)
        tableView.sectionHeaderHeight = 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }


    func search(_ query:String?, page:Int) {
        guard let query else { return }
        
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
            print(master)
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
            lblAuthors?.text = "저자 : " + authors.joined(separator: ", ")
            
            let lblPublisher = cell.viewWithTag(4) as? UILabel
            lblPublisher?.text = "출판사 : " + book.publisher
        
            let lblPrice = cell.viewWithTag(5) as? UILabel
            lblPrice?.text = String(book.price) + "원"
        
            let lblStatus = cell.viewWithTag(6) as? UILabel
            lblStatus?.text = book.status
        
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        guard let indexPath = tableView.indexPathForSelectedRow,
              let book = books?[indexPath.row]
        else { return }
        
        detailVC?.strURL = book.url
    }
    
 }


extension BookTableViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        searchBar.resignFirstResponder()
    }
}
