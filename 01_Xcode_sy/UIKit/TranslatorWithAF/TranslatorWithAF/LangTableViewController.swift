import UIKit
import Alamofire

class LangTableViewController: UITableViewController {
    var languages:[Language]?
    var query:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBOutlet weak var searchBar: UISearchBar!
    
    func translator(query: String?) {
            guard let query = query else { return }
            
            do {

                let endPoint = translatorEndPoint + "/translate?api-version=3.0&to=en,ja,fr,es"
                let headers: HTTPHeaders = [
                    "Ocp-Apim-Subscription-Key": apiKey,
                    "Ocp-Apim-Subscription-Region":"eastus"
                ]
                let body:[[String: String]] = [["Text": query]] // [1] 아하 나는 보내는 body는,  Model에 struct로 추가를 안한거군!
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: []) // 그래서 JSONEncoder 말고 Serialization 쓴거군.
                // 또는 encoding, AF에 바로 바꿔주는? 그런게 있다함
                
                // 요청 생성
                var request = URLRequest(url: URL(string: endPoint)!)
                request.httpMethod = "POST"
                request.headers = headers   // [2] 그리고 여기 기존에 강사님이 가르쳐 주셨던건, request.addValue(value, forHTTPHeaderField: key)
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // Alamofire 요청
                AF.request(request).responseDecodable(of: [Language].self) { response in
                    switch response.result {
                    case .success(let root):
//                        print(root)
                        self.languages = root
                        DispatchQueue.main.async {
                            self.tableView.reloadData() // 테이블 뷰 새로고침
                        }
                        
                    case .failure(let error):
                        print("에러 발생: \(error.localizedDescription)")
                    }
                }
                
            } catch {
                print("JSON 데이터 생성 중 오류 발생: \(error.localizedDescription)")
            }
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let language = languages?.first else { return 0 }
        return language.translations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "translation", for: indexPath)
        guard let language = languages?.first else { return cell }
        let translations = language.translations[indexPath.row]
        
        let lblTo = cell.viewWithTag(1) as? UILabel
        let lblText = cell.viewWithTag(2) as? UILabel
        lblTo?.text = translations.to
        lblText?.text = translations.text
        
        return cell
    }
    
}

extension LangTableViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        translator(query: searchBar.text)
        searchBar.resignFirstResponder()
    }
}
