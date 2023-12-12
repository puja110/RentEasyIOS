//
//  ResetPasswordViewController.swift
//  RentEasy
//
//  Created by CodeSomps on 2023-10-08.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    var button_FieldStyle = Button_FieldStyle()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button_FieldStyle.textFieldShape(newPasswordTextField)
        button_FieldStyle.textFieldShape(confirmNewPasswordTextField)
        button_FieldStyle.buttonShape(confirmButton)
    }
}
