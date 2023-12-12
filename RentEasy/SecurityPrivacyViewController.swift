//
//  SettingsViewController.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-12-03.
//

import Foundation

import UIKit

class SecurityPrivacyViewController: UIViewController {
    
    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    let dataModelManager = DataModelManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
     navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    @IBAction func onPasswordUpdate(_ sender: UIButton) {
        let userDetails = DataModelManager.shared.fetchUserDetails()
        
        guard !currentPasswordField.text!.isEmpty, !newPasswordField.text!.isEmpty, !confirmPasswordField.text!.isEmpty else {
            print("Fields cannot be empty")
         showAlert(message: "Fields cannot be empty. Please try again!")
            return
            }
        
        guard currentPasswordField.text == userDetails?.password  else {
            print("Password Mismatch")
         showAlert(message: "Wrong Password. Please try again!")
            return
            }
        
        guard newPasswordField.text == confirmPasswordField.text  else {
            print("Password Mismatch")
         showAlert(message: "Password didn't match. Please try again!")
            return
            }
        
        dataModelManager.userPasswordUpdate(password: confirmPasswordField.text!)
        
        let alertController = UIAlertController(title: "Successful", message: "Password Updated", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
