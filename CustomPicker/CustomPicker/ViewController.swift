//
//  ViewController.swift
//  CustomPicker
//
//  Created by Taslim Ansari on 26/10/18.
//  Copyright © 2018 Finoit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pickerView: TAPicker!
    var datePicker: TAPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView = TAPicker.init()
        pickerView.addPickerView(superView: self.view) { (selectedValue) in
            print(selectedValue)
        }
        pickerView.pickerViewData = [1, 2, "🙄", 3, 4, "🙄", 5, 6, 7, "🙄"]
        
        datePicker = TAPicker()
        datePicker.addDatePicker(superView: self.view) { (date) in
            print(date.description)
        }
    }

    @IBAction private func showPickerView(_ sender: UIButton) {
        if datePicker != nil {
            datePicker.hidePicker()
        }
        pickerView.showPicker()
    }
    
    @IBAction private func showDatePicker(_ sender: UIButton) {
        if pickerView != nil {
            pickerView.hidePicker()
        }
        datePicker.showPicker()
    }
}

