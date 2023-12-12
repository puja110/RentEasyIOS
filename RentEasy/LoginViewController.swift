//
//  ViewController.swift
//  RentEasy
//
//  Created by CodeSomps on 2023-10-06.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginLogoImg: UIImageView!
    
    let dataModelManager = DataModelManager.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var button_FieldStyle = Button_FieldStyle()
    var searchBarAppearance = SearchBarAppearance()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //Animation
               loginLogoImg.alpha = 0
               loginLogoImg.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
               UIView.animate(withDuration: 1.0, delay: 0.5,
                              usingSpringWithDamping: 0.7,
                              initialSpringVelocity: 0,
                              animations: {
                   self.loginLogoImg.alpha = 1
                   self.loginLogoImg.transform = .identity
               }, completion: nil)
        
        button_FieldStyle.buttonShape(loginButton)
        button_FieldStyle.buttonShape(createAccountButton)
        button_FieldStyle.textFieldShape(usernameTextField)
        button_FieldStyle.textFieldShape(passwordTextField)
        secureEye(passwordTextField)
     
    }
    
   
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {return}
          guard !username.isEmpty, !password.isEmpty else {return}
        if dataModelManager.userLogin(emailAddress: username, password: password) {
                performTabBarSegue()
            } else {
                let alertController = UIAlertController(title: "Failed", message: "Try again", preferredStyle: .alert)
                let oK = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(oK)
                present(alertController, animated: true, completion: nil)
            }
    }
    
    func performTabBarSegue() {
        if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "MyTabBar") {
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true, completion: nil)
        }
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
        passwordImageButton.addTarget(self, action: #selector(secureEyePressed), for: .touchUpInside)
    }
    @objc func secureEyePressed(passwordButton: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        let image = UIImage(systemName: imageName)
        passwordButton.setImage(image, for: .normal)
    }
}

