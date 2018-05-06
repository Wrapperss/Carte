//
//  AddAddressController.swift
//  Carte
//
//  Created by Wrappers Zhang on 2018/5/6.
//  Copyright © 2018 Wrappers. All rights reserved.
//

import Foundation
import BEMCheckBox
import IQKeyboardManagerSwift
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

class AddAddressController: UIViewController {
    
    @IBOutlet weak var defaultButton: BEMCheckBox!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setNavigation()
        defaultButton.onFillColor = UIColor.init(r: 251, g: 38, b: 44)
        defaultButton.onTintColor = UIColor(r: 251, g: 38, b: 44)
        defaultButton.onCheckColor = .white
        defaultButton.tintColor = .lightGray
        defaultButton.onAnimationType = .fill
        defaultButton.offAnimationType = .fill
        
        cityTextfield.delegate = self
    }
    
    private func setNavigation() {
        title = "编辑地址"
        let rightItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc
    private func save() {
        if checkStringAvailable(nameTextField.text),
            checkStringAvailable(phoneTextfield.text),
            checkStringAvailable(cityTextfield.text),
            checkStringAvailable(detailTextView.text) {
            if PhoneNumberRule().validate(phoneTextfield.text!) {
                
            } else {
                HUD.showError("手机号格式错误")
            }
        } else {
            HUD.showError("请填写完整信息")
        }
    }
}

extension AddAddressController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        phoneTextfield.resignFirstResponder()
        detailTextView.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cityTextfield.resignFirstResponder()
        nameTextField.resignFirstResponder()
        phoneTextfield.resignFirstResponder()
        detailTextView.resignFirstResponder()
        let _ = LZCityPickerController.showPicker(in: self) { [weak self] (address, province, city, area) in
            self?.cityTextfield.text = address
        }
    }
}
