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
        
        switch1.isOn = false
        imageView.image = UIImage(named: "reveluv")
        label1.text = "ReVeLuv"
        btnLeft.isEnabled = false
        btnRight.isEnabled = false
        label1.numberOfLines = 2
        pageControl.numberOfPages = 0
        pageControl.currentPage = 0


        segmentControl.removeAllSegments()
        for segTitle in rvNm {
            segmentControl.insertSegment(withTitle: segTitle, at: rvIdx, animated: false)
            rvIdx += 1
        }
        rvIdx = 0
        segmentControl.isEnabled = false
        
        
        slider.maximumValue = 33
        slider.minimumValue = 25
        slider.value = 0
        
        label2.text = nil
        
        stepper.maximumValue = 10
        stepper.minimumValue = 0
        stepper.stepValue = 1
        stepper.value = 0
        label3.text = "\(Int(stepper.value)) ❤️"
        
        status.progress = 0.0
        
    }

    @IBAction func actSwitch(_ sender: Any) {
        if switch1.isOn {
            rvIdx = 0
            imageView.image = UIImage(named: "rv_group")
            label1.text = "Happiness!"
            btnRight.isEnabled = true
            pageControl.numberOfPages = rvImg.count
            pageControl.currentPage = rvIdx
            segmentControl.isEnabled = true
        } else {
            rvIdx = 0
            imageView.image = UIImage(named: "reveluv")
            label1.text = "ReVeLuv"
            btnLeft.isEnabled = false
            btnRight.isEnabled = false
            
            pageControl.numberOfPages = 0
            pageControl.currentPage = 0
            segmentControl.isEnabled = false
            segmentControl.selectedSegmentIndex = -1
            
            label2.text = nil
            label3.text = nil
        }
    }
    
    @IBAction func actLeft(_ sender: Any) {
        rvIdx -= 1
        btnLeft.isEnabled = true
        btnRight.isEnabled = true
        imageView.image = UIImage(named: rvImg[rvIdx])
        label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        pageControl.currentPage = rvIdx
        if rvIdx == 0 {
            btnLeft.isEnabled = false
        }
        segmentControl.selectedSegmentIndex = -1
    }
    
    @IBAction func actRight(_ sender: Any) {
        rvIdx += 1
        btnLeft.isEnabled = true
        btnRight.isEnabled = true
        imageView.image = UIImage(named: rvImg[rvIdx])
        label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        pageControl.currentPage = rvIdx
        
        if rvIdx == rvImg.count - 1 {
            btnRight.isEnabled = false
        }
        segmentControl.selectedSegmentIndex = -1
    }
    
    
    
    @IBAction func actSegmentChanged(_ sender: Any) {
        rvIdx = segmentControl.selectedSegmentIndex
        
        if rvIdx == 0 {
            btnLeft.isEnabled = false
            btnRight.isEnabled = true
        } else if rvIdx == rvImg.count - 1 {
            btnLeft.isEnabled = true
            btnRight.isEnabled = false
        } else {
            btnLeft.isEnabled = true
            btnRight.isEnabled = true
        }
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            imageView.image = UIImage(named: rvImg[rvIdx])
            label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        case 1:
            imageView.image = UIImage(named: rvImg[rvIdx])
            label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        case 2:
            imageView.image = UIImage(named: rvImg[rvIdx])
            label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        case 3:
            imageView.image = UIImage(named: rvImg[rvIdx])
            label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        case 4:
            imageView.image = UIImage(named: rvImg[rvIdx])
            label1.text = "\(rvNm[rvIdx])\n\(rvBirth[rvIdx])"
        default:
            imageView.image = nil
            label1.text = ""
        }
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
    
    
}

