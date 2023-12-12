//
//  CustomAlert.swift
//  RentEasy
//
//  Created by Oladipupo Olasile on 2023-11-30.
//

import UIKit

class CustomAlert: UIViewController {

    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientEmail: UITextField!
    @IBOutlet weak var clientMessage: UITextField!
    
    @IBOutlet weak var alertStackView: UIStackView!
    @IBOutlet weak var alertView: UIView!
    var houses: RentDataEntity?
    var detailPageVC = DetailPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertView.layer.cornerRadius = 40
        alertView.layer.borderWidth = 1
        alertView.layer.borderColor = UIColor.gray.cgColor
        alertStackView.layer.cornerRadius = 40
        
        clientName.layer.borderWidth = 0.8
        clientName.layer.borderColor = UIColor.green.cgColor
        
        clientEmail.layer.borderWidth = 0.8
        clientEmail.layer.borderColor = UIColor.green.cgColor
        
        clientMessage.layer.borderWidth = 0.8
        clientMessage.layer.borderColor = UIColor.green.cgColor
    }

    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let houses = houses else {
            print("returned")
            return
        }
        houses.bookedItem.toggle()
        print("Booked")
        houses.status = "Booked"
        DataModelManager.shared.saveContext()
        bookingSuccessAlert()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func bookingSuccessAlert() {
        let alert = UIAlertController(title: "Booking Successful", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        self.dismiss(animated: true)
    }
    
}
