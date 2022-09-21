//
//  RegisterVC.swift
//  Trajnohu
//
//  Created by user226415 on 9/21/22.
//

import UIKit
import IBAnimatable

class RegisterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTxtField: AnimatableTextField!
    @IBOutlet weak var emailTxtField: AnimatableTextField!
    @IBOutlet weak var passwordTxtField: AnimatableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    func setupTextField() {
        usernameTxtField.delegate = self
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTxtField {
            usernameTxtField.borderWidth = 1
        } else if textField == emailTxtField {
            emailTxtField.borderWidth = 1
        } else if textField == passwordTxtField {
            passwordTxtField.borderWidth = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTxtField {
            usernameTxtField.borderWidth = 0
        } else if textField == emailTxtField {
            emailTxtField.borderWidth = 0
        } else if textField == passwordTxtField {
            passwordTxtField.borderWidth = 0
        }
    }

}
