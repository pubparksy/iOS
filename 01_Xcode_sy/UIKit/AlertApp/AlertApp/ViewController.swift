import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var btn3: UIButton!
    
    @IBAction func infoAlert(_ sender: Any) {
        let alert = UIAlertController(title: "공지", message: "수업시간 졸음 금지", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "확인했습니다.", style: .default) { _ in
            self.btn3.isEnabled = true
            
        }
        let action2 = UIAlertAction(title: "졸 수도 있어요...", style: .default)
        alert.addAction(action)
        alert.addAction(action2)
        present(alert, animated: true) {
            print("infoAlert present")
        }
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        let alert = UIAlertController(title: "공지", message: "졸지 마세요!!!", preferredStyle: .alert)
        
        /** action을 누르고 아무 이벤트 안 일어남. */
//        let actionOk = UIAlertAction(title: "네. 확인했습니다.", style: .default)
//        let actionNo = UIAlertAction(title: "싫어요. 아프면 잘수도.", style: .cancel)
        
        
        /** action을 누르면 수행할 소스 추가. */
        let actionOk = UIAlertAction(title: "네. 확인했습니다.", style: .default) { _ in
            print("Ok 버튼을 누름")
        }
        let actionNo = UIAlertAction(title: "싫어요. 아프면 잘수도.", style: .cancel) { _ in
            print("No 버튼을 누름")
        }
        
        alert.addAction(actionOk)
        alert.addAction(actionNo)
        
        present(alert, animated: true)

    }
    
    
    @IBAction func selectAction(_ sender: Any) {
        let alert = UIAlertController(title: "2차 공지", message: "졸지 마시고, 졸리면 제출하세요.", preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "네. 확인했습니다.", style: .default) { _ in
            print("Ok 버튼 누름")
        }
        let actionNo = UIAlertAction(title: "귀찮아요...", style: .default) { _ in
            print("강경파")
            self.btn3.isEnabled = false
            
        }
        let actionOption = UIAlertAction(title: "졸음 증명서 낼게요.", style: .default) { _ in
            print("많이 피곤하다함")
            self.btn3.isEnabled = false
        }
        
        alert.addAction(actionOk)
        alert.addAction(actionNo)
        alert.addAction(actionOption)
        
        present(alert, animated: true) {
            print("alert 버튼 수행완료")
        }
    }
    
    
    
}

