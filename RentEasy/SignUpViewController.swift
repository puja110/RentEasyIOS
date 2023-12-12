//
//  SignUpViewController.swift
//  RentEasy
//
//  Created by CodeSomps on 2023-10-08.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var alreadyHaveAnAccountLabel: UILabel!
    
    var button_FieldStyle = Button_FieldStyle()
    let dataModelManager = DataModelManager.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button_FieldStyle.buttonShape(signUpButton)
        button_FieldStyle.textFieldShape(firstNameTextField)
        button_FieldStyle.textFieldShape(lastNameTextField)
        button_FieldStyle.textFieldShape(emailTextField)
        button_FieldStyle.textFieldShape(phoneNumberTextField)
        button_FieldStyle.textFieldShape(passwordTextField)
        button_FieldStyle.textFieldShape(confirmPasswordTextField)
        button_FieldStyle.buttonShape(signUpButton)
        secureEye(passwordTextField)
        secureEye(confirmPasswordTextField)
        
        let alreadyHaveAccountGesture = UITapGestureRecognizer(target: self, action: #selector(alreadyHaveAnAccountLabelTapped))
               alreadyHaveAnAccountLabel.isUserInteractionEnabled = true
               alreadyHaveAnAccountLabel.addGestureRecognizer(alreadyHaveAccountGesture)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else {return}
        
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !phoneNumber.isEmpty, !firstName.isEmpty, !lastName.isEmpty else {
            alertMessage(message: "All fields must be filled.")
            return
        }
        
        guard password == confirmPassword else {
            alertMessage(message: "Password do not match")
            return
        }
        dataModelManager.userRegistration(email: email,
                                          password: password,
                                          firstName: firstName,
                                          lastName: lastName,
                                          phoneNumber: phoneNumber,
                                          context: context)
        
        let alertController = UIAlertController(title: "Successful", message: "Go to Login Page", preferredStyle: .alert)
        let oK = UIAlertAction(title: "OK", style: .destructive) { _ in
            self.customSegue()
        }
        alertController.addAction(oK)
        present(alertController, animated: true, completion: nil)
    }
    
    func alertMessage(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let oK = UIAlertAction(title: "OK", style: .destructive)
        alertController.addAction(oK)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func alreadyHaveAnAccountLabelTapped() {
        customSegue()
    }
    
    private func customSegue() {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginPage") else {
            return
        }
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    private func secureEye(_ textField: UITextField) {
            let passwordImage = UIImage(systemName: "eye.slash")
            let passwordImageButton = UIButton(type: .custom)
            passwordImageButton.setImage(passwordImage, for: .normal)
            passwordImageButton.tintColor = UIColor.black
            passwordImageButton.frame = CGRect(x: 0, y: 0, width: 40, height: 50)
            let paddingRightConstant = UIView(frame: passwordImageButton.frame)
            paddingRightConstant.addSubview(passwordImageButton)
            textField.rightView = paddingRightConstant
            textField.rightViewMode = .always
            passwordImageButton.addTarget(self, action: #selector(secureEyePressed(_:)), for: .touchUpInside)
        }

        @objc func secureEyePressed(_ sender: UIButton) {
            if let textField = sender.superview?.superview as? UITextField {
                textField.isSecureTextEntry.toggle()
                let imageName = textField.isSecureTextEntry ? "eye.slash" : "eye"
                let image = UIImage(systemName: imageName)
                sender.setImage(image, for: .normal)
            }
        }
}
