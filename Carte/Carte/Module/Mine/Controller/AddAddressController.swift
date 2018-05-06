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
import PromiseKit

class AddAddressController: UIViewController {
    
    enum Operate {
        case add
        case modify(Address)
    }
    
    @IBOutlet weak var defaultButton: BEMCheckBox!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    var operate = Operate.add

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addData()
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
                post(Address(contract: nameTextField.text!,
                             phoneNum: phoneTextfield.text!,
                             city: cityTextfield.text!,
                             detail: detailTextView.text!,
                             isDefault: defaultButton.on ? 1 : 0,
                             userId: Default.Account.integer(forKey: .userId)))
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

extension AddAddressController {
    fileprivate func addData() {
        switch operate {
        case .modify(let address):
            nameTextField.text = address.contract ?? ""
            phoneTextfield.text = address.phoneNum ?? ""
            detailTextView.text = address.detail ?? ""
            cityTextfield.text = address.city ?? ""
            if address.isDefault == 1 {
                defaultButton.on = true
            } else {
                defaultButton.on = false
            }
        default:
            break
        }
    }
    
    fileprivate func post(_ address: Address) {
        HUD.wait()
        switch operate {
        case .add:
            AddressAPI
                .postAddress(address: address)
                .always {
                    HUD.clear()
                }
                .then { [weak self] (_) -> Void in
                    HUD.showSuccess("保存成功")
                    Delay(time: 1.0, task: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
                .catch { (_) in
                    HUD.showError("发生错误")
            }
            
        case .modify(let oldAddress):
            AddressAPI
                .updataUserAddres(addressId: oldAddress.id ?? 0, address: address)
                .always {
                    HUD.clear()
                }
                .then { [weak self] (_) -> Void in
                    HUD.showSuccess("保存成功")
                    Delay(time: 1.0, task: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
                .catch { (_) in
                    HUD.showError("发生错误")
            }
        }
    }
}

