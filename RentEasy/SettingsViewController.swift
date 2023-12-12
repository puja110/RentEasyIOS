//
//  SettingsViewController.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-12-03.
//

import Foundation

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    let dataModelManager = DataModelManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     navigationController?.setNavigationBarHidden(false, animated: true)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        
        if let userDetails = DataModelManager.shared.fetchUserDetails() {
            let firstName = userDetails.firstName
            let lastName = userDetails.lastName
            let emailAddress = userDetails.emailAddress
            
            firstNameTextField.text = firstName
            lastNameTextField.text = lastName
            emailTextField.text = emailAddress
            phoneNumberTextField.text = userDetails.phoneNumber
        }
    }
    
    
    @IBAction func onUpdateProfile(_ sender: UIButton) {
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !phoneNumber.isEmpty else {
            print("Fields cannot be empty")
         showAlert(message: "Fields cannot be empty. Please try again!")
            return
            }
        
        dataModelManager.userProfileUpdate(email: emailTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, phoneNumber: phoneNumberTextField.text!)
        
        let alertController = UIAlertController(title: "Successful", message: "Profile Updated", preferredStyle: .alert)
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
