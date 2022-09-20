//
//  ViewController.swift
//  Trajnohu
//
//  Created by user226415 on 9/20/22.
//

import UIKit
import IBAnimatable

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var loginView: AnimatableView!
    @IBOutlet weak var passwordTxtField: AnimatableTextField!
    @IBOutlet weak var usernameTxtField: AnimatableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
}

//extension that setups textField styles
extension ViewController {
    
    func setupTextField() {
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTxtField {
            usernameTxtField.borderWidth = 1
        } else if textField == passwordTxtField {
            passwordTxtField.borderWidth = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTxtField {
            usernameTxtField.borderWidth = 0
        } else if textField == passwordTxtField {
            passwordTxtField.borderWidth = 0
        }
        
    }
}

