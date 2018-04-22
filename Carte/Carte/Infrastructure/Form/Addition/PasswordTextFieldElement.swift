//
//  PasswordTextFieldElement.swift
//  CreamsAgent
//
//  Created by Rawlings on 08/11/2017.
//  Copyright © 2017 Hangzhou Craftsman Network Technology Co.,Ltd. All rights reserved.
//

import Foundation
import PasswordTextField

private let defaultSecureImages = (show: "textfield_openEye", hide: "textfield_closeEye")


class PasswordTextFieldElement: TextFieldElement {
    
    let showSecureTextImage: String
    let hideSecureTextImage: String
    
    var passwordTextField: PasswordTextField?
    weak var passwordDelegate: TextFieldElementDelegate?

    init(showSecureTextImage: String = defaultSecureImages.show, hideSecureTextImage: String = defaultSecureImages.hide,  holder: String?, text: String? = nil, size: CGSize = .zero, keyboard: UIKeyboardType = .default, delegate: TextFieldElementDelegate? = nil) {
        self.showSecureTextImage = showSecureTextImage
        self.hideSecureTextImage = hideSecureTextImage
        super.init(holder: holder, text: text, size: size, keyboard: keyboard, delegate: delegate)
    }
    
    override func generateViewWrapper() -> ViewWrapper {
        let tf = PasswordTextField()
        passwordTextField = tf
        tf.addTarget(self, action: #selector(textFieldEditingChanged(tf:)), for: .editingChanged)
        tf.customShowSecureTextImage = UIImage(named: showSecureTextImage)
        tf.customHideSecureTextImage = UIImage(named: hideSecureTextImage)
        tf.validationRule = RegexRule(regex: PasswordRule.regex, errorMessage: PasswordRule().errorMessage())
        tf.showButtonWhile = .Always
        setup(tf: tf)
        return ViewWrapper(tf)
    }
}

extension PasswordTextFieldElement {
    
    var isValid: Bool {
        let isValid = passwordTextField?.isValid() ?? false
        if !isValid { HUD.showError(passwordTextField?.errorMessage() ?? PasswordRule().errorMessage()) }
        return isValid
    }
}
