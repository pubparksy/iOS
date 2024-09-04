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
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        /**
         만약 let addrSido 대신
         let addrDic의 Key값들을 따로? 배열로 쓰고 싶으면?
         addrDic.keys 는 또다시 Dic<String:<String>> 이래서
         for key in addrDic.keys 로 써야만 key가 string으로 나오던데
        그럼 따로 배열 변수를 선언해서 담을 걸 써야하나..?
         
         
         */

        
        if component == 0 {
            return addrDic.keys.count
        } else {
        
        
            var numberOfRows = 0
            
// 1)
//            for sido in addrDic.keys {
//                if addrSido[pickerView.selectedRow(inComponent: 0)] == sido {
//                    if let cnt = addrDic[sido]?.count {
//                        numberOfRows = cnt
//                    }
//                }
//            }

            
            
// 2)
            var arrSido = [String]()
            for (key,_) in addrDic {
                arrSido.append(key)
            }
            for _ in 0..<arrSido.count {
                if let val = addrDic[arrSido[pickerView.selectedRow(inComponent: 0)]] {
                    numberOfRows = val.count
                }
            }
      
            
            
            return numberOfRows
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
            if let arr = addrDic[addrSido[sidoIdx]] { // value의 총 갯수. 각 지역구 총 갯수
                for _ in 0..<arr.count {
                    lbl.text = arr[row]
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
            txtView.text = addrDic[addrSido[pickerView.selectedRow(inComponent: 0)]]?.joined(separator: ", ")
            pickerView.reloadComponent(1)
            
        } else {

            
        }
        
    }
    
}

