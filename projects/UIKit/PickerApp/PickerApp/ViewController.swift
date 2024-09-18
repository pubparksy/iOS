import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /** api 소스 백업 .swift 참고 */

    let fruits = ["사과", "배", "포도", "망고", "딸기", "바나나", "파인애플"]

    @IBOutlet weak var showPicker: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        showPicker.tintColor = .clear
        createPickerView()
//        dismissPickerView()
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruits.count
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return fruits[row]
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showPicker.text = fruits[row]
    }


    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        showPicker.inputView = pickerView
    }

//    func dismissPickerView() {
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.action))
//        toolBar.setItems([button], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        showPicker.inputAccessoryView = toolBar
//    }
}
