//
//  ViewController.swift
//  SMViewer
//
//  Created by ... on 8/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.maximumValue = 33
        slider.minimumValue = 25
        slider.value = 0
        
        stepper.minimumValue = 2014
        stepper.maximumValue = 2024
        stepper.stepValue = 1
        stepper.value = 0
        
    }
    @IBAction func actStepperValueChange(_ sender: Any) {
        label1.text = "활동년도 : \(Int(stepper.value))년"
    }
    
    @IBAction func actSwitch(_ sender: Any) {
        if switch1.isOn {
            imageView.image = UIImage(named: "irene")
            label1.text = "스위치를 켰습니다"
        } else {
            imageView.image = nil
            label1.text = "스위치를 껐습니다"
        }
    }
    
    @IBAction func btnFn(_ sender: Any) {
        imageView.image = UIImage(named: "irene")
        label1.text = "아이린을 눌러주셨습니다."
        
    }
    
    @IBAction func actSliderValueChange(_ sender: Any) {
        label1.text = "\(Int(slider.value))살"
    }
    
    @IBAction func actSegmentChanged(_ sender: Any) {
        
        switch segmentControl.selectedSegmentIndex {
        case 0 :
            imageView.image = UIImage(named: "seulgi")
            label1.text = "\(segmentControl.selectedSegmentIndex+1)번째 슬기를 눌러주셨습니다."
        case 1 :
            imageView.image = UIImage(named: "wendy")
            label1.text = "\(segmentControl.selectedSegmentIndex+1)번째 웬디를 눌러주셨습니다."
        case 2 :
            imageView.image = UIImage(named: "joy")
            label1.text = "\(segmentControl.selectedSegmentIndex+1)번째 조이를 눌러주셨습니다."
        case 3 :
            imageView.image = UIImage(named: "yeri")
            label1.text = "\(segmentControl.selectedSegmentIndex+1)번째 예리를 눌러주셨습니다."
        default:
            imageView.image = nil
        }
 
        
    }
    
}

