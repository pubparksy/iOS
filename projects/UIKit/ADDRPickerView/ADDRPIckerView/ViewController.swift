//
//  ViewController.swift
//  ADDRPIckerView
//
//  Created by soyoung Park on 9/5/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let addrSido = ["경기도","대전광역시","서울","제주"]
    let addrDic:[String:[String]] = [
        "경기도" : ["가평군", "고양시", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "부천시 소사구", "부천시 오정구", "부천시 원미구", "성남시", "성남시 분당구", "성남시 수정구", "성남시 중원구", "수원시", "수원시 권선구", "수원시 영통구", "수원시 장안구", "수원시 팔달구", "시흥시", "안산시", "안산시 단원구", "안산시 상록구", "안성시", "안양시", "안양시 동안구", "안양시 만안구"]
    , "대전광역시" : ["대덕구", "동구", "서구", "유성구", "중구"]
    , "서울" : ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    , "제주" : ["서귀포시", "제주시"]]
    
    let addrImgs = ["addr1","addr2","addr3","addr4"]
    var arrStr:[String]?
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        lbl1.text = addrSido[0]
        txtView.text = addrDic[addrSido[pickerView.selectedRow(inComponent: 0)]]?.joined(separator: ", ")
        
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if component == 0 {
            return addrDic.keys.count
        } else {
            
            if let arrStr {
                return arrStr.count
            } else {
                arrStr = addrDic[addrSido[0]]
                guard let arrStr = arrStr else {
                    return 0
                }
                return arrStr.count
            }
            
            
        }
     }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 0 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: addrImgs[row])
            imageView.contentMode = .scaleAspectFit
            return imageView
        } else {
            let lbl = UILabel()
            let sidoIdx = pickerView.selectedRow(inComponent: 0)
            if let gus = addrDic[addrSido[sidoIdx]] { // value의 총 갯수. 각 지역구 총 갯수
                for _ in 0 ..< gus.count  { // i: 0~33
                    lbl.text = gus[row]
                }
            }
            lbl.textAlignment = .center
            return lbl
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            imageView.image = UIImage(named: addrImgs[row])
            imageView.contentMode = .scaleAspectFill
            lbl1.text = addrSido[pickerView.selectedRow(inComponent: 0)]
            arrStr = addrDic[addrSido[pickerView.selectedRow(inComponent: 0)]]
            txtView.text = addrDic[addrSido[pickerView.selectedRow(inComponent: 0)]]?.joined(separator: ", ")
            pickerView.reloadComponent(1)
        } else {
            
        }
        
    }
    
}

