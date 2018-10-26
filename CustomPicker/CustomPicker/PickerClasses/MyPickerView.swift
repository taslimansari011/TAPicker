//
//  MyPickerView.swift
//  CustomPicker
//
//  Created by Taslim Ansari on 26/10/18.
//  Copyright © 2018 Finoit. All rights reserved.
//

import UIKit

enum BarButtonType {
    case done
    case cancel
}

typealias PickerCompletion = (Any) -> Void
typealias DatePickerCompletion = (Date) -> Void

class TAPicker: UIView {
    
    var frameShowPickerView: CGRect!
    var frameHidePickerView: CGRect!
    
    var pickerView: UIPickerView!
    var pickerViewData: [Any] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    var completionBlock: PickerCompletion!
    var numberOfComponents: Int = 1
    
    var datePicker: UIDatePicker!
    var datePicked: DatePickerCompletion!
    var selectedDate = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    func setupContainerView(superView: UIView) {
        var rect = CGRect.init(x: 0, y: superView.frame.height, width: superView.frame.width, height: 200)
        
        self.frameShowPickerView = CGRect.init(x: 0, y: superView.frame.height - 200, width: superView.frame.width, height: 200)
        self.frameHidePickerView = rect
        
        self.frame = rect
        
        rect = CGRect.init(x: 0, y: 0, width: superView.frame.width, height: 30)
        let headerView = UIView.init(frame: rect)
        headerView.backgroundColor = UIColor.lightGray
        addHeaderButtons(headerView: headerView)
        
        self.addSubview(headerView)
        superView.addSubview(self)
    }
    
    func addPickerView(superView: UIView, handler: @escaping PickerCompletion) {
        self.completionBlock = handler
        
        let rect = CGRect.init(x: 0, y: 30, width: superView.frame.width, height: 170)
        pickerView = UIPickerView.init(frame: rect)
        pickerView.delegate = self
        
        self.addSubview(pickerView)
        setupContainerView(superView: superView)
    }
    
    func addDatePicker(superView: UIView, hanlder: @escaping DatePickerCompletion) {
        self.datePicked = hanlder
        
        let rect = CGRect.init(x: 0, y: 30, width: superView.frame.width, height: 170)
        datePicker = UIDatePicker.init(frame: rect)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.timeZone = TimeZone.init(abbreviation: "UTC")
        self.addSubview(datePicker)
        setupContainerView(superView: superView)
    }
    
    func showPicker(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.frame = self.frameShowPickerView
            }
        }
    }
    
    func hidePicker(animated: Bool = true) {
        UIView.animate(withDuration: 0.3) {
            self.frame = self.frameHidePickerView
        }
    }
    
    func addHeaderButtons(headerView: UIView) {
        let doneButton = getButtonWithTitle(title: "Done", frame: CGRect.init(x: self.frame.width - 70, y: 5, width: 70, height: 20), selector: #selector(doneButtonTapped))
        let cancelButton = getButtonWithTitle(title: "Cancel", frame: CGRect.init(x: 0, y: 5, width: 70, height: 20), selector: #selector(cancelButtonTapped))
        headerView.addSubview(doneButton)
        headerView.addSubview(cancelButton)
    }
    
//    func getBarButtonWith(type: UIBarButtonItem.SystemItem, selector: Selector) -> UIBarButtonItem {
//        let button = UIBarButtonItem.init(barButtonSystemItem: type, target: self, action: selector)
//        return button
//    }
    
    func getButtonWithTitle(title: String, frame: CGRect, selector: Selector) -> UIButton {
        let button = UIButton.init(frame: frame)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    // MARK: - Button Actions
    @objc func doneButtonTapped() {
        if pickerView != nil {
            let value = pickerViewData[pickerView.selectedRow(inComponent: 0)]
            completionBlock(value)
        } else if datePicker != nil {
            datePicked(datePicker.date)
        }
        hidePicker()
    }
    
    @objc func cancelButtonTapped() {
        hidePicker()
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension TAPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerViewData[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
