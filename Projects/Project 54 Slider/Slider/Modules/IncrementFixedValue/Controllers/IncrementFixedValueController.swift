//
//  IncrementFixedValueController.swift
//  Slider
//
//  Created by Pham Quang Huy on 2022/01/04.
//

import UIKit

class IncrementFixedValueController: UIViewController {

    @IBOutlet weak var valueLb: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    let step: Float = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        
        if roundedValue > 0 {
            sender.value = roundedValue
        }
        
        valueLb.text = "\(Int(roundedValue))"
    }
    
    @IBAction func degreesValue(_ sender: Any) {
        if slider.value >= 5 {
            let value = slider.value - 5
            let roundedValue = round(value / step) * step
            self.slider.setValue(roundedValue, animated: true)
            valueLb.text = "\(Int(roundedValue))"
        }
    }
    
    @IBAction func increaseValue(_ sender: Any) {
        if slider.value <= 95 {
            let value = slider.value + 5
            let roundedValue = round(value / step) * step
            self.slider.setValue(roundedValue, animated: true)
            valueLb.text = "\(Int(roundedValue))"
        }
    }
}
