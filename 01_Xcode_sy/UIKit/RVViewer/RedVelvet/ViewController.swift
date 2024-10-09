//
//  ViewController.swift
//  RedVelvet
//
//  Created by rv on 9/1/24.
//

import UIKit

class ViewController: UIViewController {

    let rvImg = ["rv1", "rv2", "rv3", "rv4", "rv5"]
    let rvNm = ["irene", "seulgi", "wendy", "joy", "yeri"]
    let rvBirth = ["91.03.29", "94.02.10","94.02.21","96.09.03","99.03.05"]
    let sfSymbols = ["heart","heart.fill","house","house.fill","person","person.3"]
    // imageView.image = UIImage(systemName: "bolt.heart.fill")
    
    var rvIdx = 0

    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var status: UIProgressView!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = rvImg.count
        
        
        segmentControl.removeAllSegments() // segTitle 디폴트 세팅 삭제
        for segTitle in rvNm {
            segmentControl.insertSegment(withTitle: segTitle, at: rvIdx, animated: false)
            rvIdx += 1
        }
        rvIdx = 0 // segTitle 땜에 돌려주고 초기화
        
        slider.maximumValue = 33
        slider.minimumValue = 25
 
        stepper.maximumValue = 10
        stepper.minimumValue = 0
        stepper.stepValue = 1
        
        switch1.isOn = false
        disabled()
    }

    @IBAction func actSwitch(_ sender: Any) {

        if switch1.isOn {
            btnLeft.isEnabled = true
            btnRight.isEnabled = true
            pageControl.isEnabled = true
            segmentControl.isEnabled = true
            slider.isEnabled = true
            stepper.isEnabled = true
            
            changeRvImgRvInfo(rvIdx)

            imageView.image = UIImage(named: "rv_group")
            label1.text = "Happiness!"

        } else {
            disabled()
        }
        
    }
    
    @IBAction func actLeft(_ sender: Any) {
        rvIdx -= 1
        changeRvImgRvInfo(rvIdx)
        segmentControl.selectedSegmentIndex = -1
    }
    
    @IBAction func actRight(_ sender: Any) {
        rvIdx += 1
        changeRvImgRvInfo(rvIdx)
        segmentControl.selectedSegmentIndex = -1
    }
    
    @IBAction func changePage(_ sender: UIPageControl) {
        rvIdx = sender.currentPage
        changeRvImgRvInfo(rvIdx)
    }
    
    @IBAction func actSegmentChanged(_ sender: Any) {
        rvIdx = segmentControl.selectedSegmentIndex
        changeRvImgRvInfo(rvIdx)
    }
    
    @IBAction func actSliderValueChange(_ sender: Any) {
//        label2.numberOfLines = 2
        label2.text = "멤버들 나이는 \(Int(slider.value))살"
    }
    
    
    
    
    
    @IBAction func actStepperValueChange(_ sender: Any) {
        label3.text = "\(Int(stepper.value)) ❤️"
//        let temp = "0.\(stepper.value)"
        status.setProgress(Float(stepper.value), animated: true)
    }
    

    
    
    
    func changeRvImgRvInfo(_ rvIdx:Int) {
        imageView.image = UIImage(named: rvImg[rvIdx])
        label1.numberOfLines = 2
        label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        pageControl.currentPage = rvIdx
        
        btnLeft.isEnabled = true
        btnRight.isEnabled = true
        if rvIdx == 0 {
            btnLeft.isEnabled = false
        } else if rvIdx == rvImg.count - 1 {
            btnRight.isEnabled = false
        }
    }
    
    func disabled() {
        rvIdx = 0
        
        btnLeft.isEnabled = false
        btnRight.isEnabled = false
        imageView.image = UIImage(named: "reveluv")
        label1.text = "ReVeLuv"
        
        pageControl.currentPage = 0
        pageControl.isEnabled = false

        segmentControl.isEnabled = false
        segmentControl.selectedSegmentIndex = -1
        
        /**
         // 이렇게 특정 idx에만 설정을 하드코딩으로 쓸 수도 있다
         segmentControl.setTitle("네번째", forSegmentAt: 3)
         segmentControl.setEnabled(true, forSegmentAt: 2)
         segmentControl.selectedSegmentIndex = 3
         **/
        
        slider.value = 0
        slider.isEnabled = false
        
        label2.text = nil
        
        label3.text = "0 ❤️"
        status.progress = 0
        stepper.value = 0
        stepper.isEnabled = false
    }
    
    
}

