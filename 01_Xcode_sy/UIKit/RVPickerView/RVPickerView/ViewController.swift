//
//  ViewController.swift
//  RVPickerView
//
//  Created by 박소영 on 9/3/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let rvs = ["아이린", "슬기", "웬디", "조이", "예리"]
    let rvImages = ["rv1","rv2","rv3","rv4","rv5","rv6","rv7"]
    let rvInfo = ["리더, 배주현, 대구, 1991년 3월 29일,158cm, A형, 225mm"
    , "메인댄서, 강슬기, 안산, 1994년 2월 10일, 161cm, A형, 230mm"
    , "메인보컬, 손승완, 서울, 1994년 2월 21일, 160cm, O형, 235mm"
    , "리드래퍼, 박수영, 제주, 1996년 9월 3일, 167cm, A형, 240mm"
    , "서브보컬, 김예림, 서울, 1999년 3월 5일, 158cm, O형, 225mm"]
    let sfSymbols = ["cloud.sleet","fleuron","metronome","theatermasks.fill","fireworks","bird"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        imageView.image = UIImage(named: "reveluv")
        lblName.text = "RedVelvet"
        
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2 // rvs, sfSymbols
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? rvs.count : sfSymbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if component == 0 {
            let lbl = UILabel()
            lbl.text = rvs[row]
            lbl.textAlignment = .center
            return lbl
        } else {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: sfSymbols[row])
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            imageView.image = UIImage(named: rvImages[row])
            lblName.text = rvs[row] + " with " +  sfSymbols[pickerView.selectedRow(inComponent: 1)]
            lblDesc.text = rvInfo[row]
        } else {
            imageView.image = UIImage(systemName: sfSymbols[row])
            imageView.contentMode = .scaleAspectFit
            lblName.text = rvs[pickerView.selectedRow(inComponent: 0)] + " with " + sfSymbols[row]
            lblDesc.text = sfSymbols[row]
        }
    }
    
    
    @IBAction func actRoll(_ sender: Any) {
        pickerView.selectRow(2, inComponent: 0, animated: true)
        imageView.image = UIImage(named: rvImages[2])
        lblName.text = rvs[2] + " with " + sfSymbols[pickerView.selectedRow(inComponent: 1)]
        lblDesc.text = rvInfo[2]
    }
    
}

