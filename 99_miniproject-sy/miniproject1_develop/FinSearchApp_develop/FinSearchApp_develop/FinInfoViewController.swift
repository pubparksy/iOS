// File Name : FinInfoViewController.swift 
// Auther    : sy 
// Date      : 10/9/24

import UIKit

class FinInfoViewController: UIViewController, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "info1", for: indexPath)
        
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "info2", for: indexPath)
        } else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "info3", for: indexPath)
        }
        
        return cell
    }
    

}
