//
//  SearchFilterView.swift
//  RentEasy
//
//  Created by CodeSomps on 2023-11-21.
//

import UIKit

class SearchFilterView: UIViewController {

    @IBOutlet weak var popUpStack: UIStackView!
    @IBOutlet weak var popBackgroundView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sliderPriceRange: UISlider!
    @IBOutlet var propertyTypeButtons: [UIButton]!
    
    var sliderAndPropertyTypeResults: [RentDataEntity] = []
    var destinationVC: FilteredResultViewController?
    var selectedPropertyType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "FilteredResult") as? FilteredResultViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        popBackgroundView.layer.cornerRadius = 40
        popUpStack.layer.cornerRadius = 40
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderButton(_ sender: UISlider) {
        let currentAmount = Int(sender.value)
               priceLabel.text = "$\(currentAmount) /month"
    }
    
    @IBAction func propertyTypeButtons(_ sender: UIButton) {
        for button in propertyTypeButtons {
            if button == sender {
                button.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
                if let currentTitle = button.titleLabel?.text {
                    selectedPropertyType = currentTitle
                }
            } else {
                button.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
    
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        if selectedPropertyType.isEmpty {
            selectPropertyAlert()
            return
        }
        let dataModelManager = DataModelManager.shared
        let amountToSearch = Int(sliderPriceRange.value)
        sliderAndPropertyTypeResults = dataModelManager.sliderAndPropertyTypeSearch(sliderAmount: amountToSearch, propertyType: selectedPropertyType)
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "FilteredResult") as? FilteredResultViewController {
            destinationVC.filteredRentData = sliderAndPropertyTypeResults
            destinationVC.modalPresentationStyle = .pageSheet
            if let bottomSheet = destinationVC.presentationController as? UISheetPresentationController {
                bottomSheet.detents = [.medium(), .large()]
                bottomSheet.largestUndimmedDetentIdentifier = .medium
                bottomSheet.preferredCornerRadius = 40
                bottomSheet.prefersScrollingExpandsWhenScrolledToEdge = false
                bottomSheet.prefersGrabberVisible = true
            }
            present(destinationVC, animated: true)
        } else {
            print("Failed")
        }
    }
    
    func selectPropertyAlert() {
        let alert = UIAlertController(title: "Select a property type", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
