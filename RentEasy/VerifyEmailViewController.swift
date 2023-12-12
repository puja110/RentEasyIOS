//
//  VerifyEmailViewController.swift
//  RentEasy
//
//  Created by CodeSomps on 2023-10-08.
//

import UIKit

class VerifyEmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var getCodeTextField: UITextField!
    @IBOutlet weak var getCodeButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    
    var button_FieldStyle = Button_FieldStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button_FieldStyle.textFieldShape(emailTextField)
        button_FieldStyle.textFieldShape(getCodeTextField)
        button_FieldStyle.buttonShape(getCodeButton)
        button_FieldStyle.buttonShape(verifyButton)
        
        
    }
}
