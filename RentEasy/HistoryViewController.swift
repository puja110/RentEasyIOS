//
//  HistoryViewController.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-11-04.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var availableButton: UIButton!
    @IBOutlet weak var bookedButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var allHistoryData: [RentDataEntity] = []
    var availableHistoryData: [RentDataEntity] = []
    var bookedHistoryData: [RentDataEntity] = []
    var currentDataSource: [RentDataEntity] = []
    var searchBarAppearance = SearchBarAppearance()
    var buttonTextField = Button_FieldStyle()
    var dataModelManager = DataModelManager()
    let appGreenColor = UIColor(red: 144.0/255.0, green: 223.0/255.0, blue: 196.0/255.0, alpha: 1.0)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allHistoryData = DataModelManager.shared.loadPostedItems()
        availableHistoryData = DataModelManager.shared.loadPostedItems()
        bookedHistoryData = DataModelManager.shared.loadBookedItems()
        allHistoryData = availableHistoryData + bookedHistoryData
        currentDataSource = allHistoryData
        tableView.reloadData()

        selectedButton(allButton)
        navigationController?.setNavigationBarHidden(true, animated: true)

        historyLabel.isHidden = currentDataSource.isEmpty ? true : false
        tableView.backgroundView = currentDataSource.isEmpty ? buttonTextField.emptyCheck(with: "No history") : nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Button Appearance
        buttonTextField.changeButtonAppearance(myButton: allButton)
        buttonTextField.changeButtonAppearance(myButton: availableButton)
        buttonTextField.changeButtonAppearance(myButton: bookedButton)
        tableView.reloadData()
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
    }
    
    
    @IBAction func allButtonPressed(_ sender: UIButton) {
        currentDataSource = allHistoryData
        historyLabel.isHidden = currentDataSource.isEmpty ? true : false
        tableView.backgroundView = currentDataSource.isEmpty ? buttonTextField.emptyCheck(with: "No history") : nil
        historyLabel.text = currentDataSource.isEmpty ? "No History" : "All History"
        selectedButton(sender)
        tableView.reloadData()
    }
    
    
    @IBAction func availableButtonPressed(_ sender: UIButton) {
        currentDataSource = availableHistoryData
        historyLabel.isHidden = currentDataSource.isEmpty ? true : false
        tableView.backgroundView = currentDataSource.isEmpty ? buttonTextField.emptyCheck(with: "No available property") : nil
        historyLabel.text = currentDataSource.isEmpty ? "No History" : "Available History"
       selectedButton(sender)
        tableView.reloadData()
    }
    
    @IBAction func bookedButtonPressed(_ sender: UIButton) {
        currentDataSource = bookedHistoryData
        historyLabel.isHidden = currentDataSource.isEmpty ? true : false
        tableView.backgroundView = currentDataSource.isEmpty ? buttonTextField.emptyCheck(with: "No booked history") : nil
        historyLabel.text = currentDataSource.isEmpty ? "No History" : "Booked History"
        selectedButton(sender)
        tableView.reloadData()
       
    }
    
    func selectedButton(_ sender: UIButton) {
        let buttons = [allButton, bookedButton, availableButton]
        for button in buttons {
            button?.isSelected = (button == sender)
            button?.backgroundColor = button?.isSelected == true ? appGreenColor : UIColor.white
        }
    }
}


extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRentData = currentDataSource[indexPath.row]
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailPageID") as? DetailPageViewController {
            destinationVC.selectedItem = selectedRentData
            destinationVC.favorite = selectedRentData.isFavorite
            navigationController?.pushViewController(destinationVC, animated: true)
        } else {
            print("Failed.")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
        let houses = currentDataSource[indexPath.row]
        cell.houseName.text = houses.name
        cell.houseAddress.text = houses.address
        cell.houseSize.text = houses.type
        cell.houseAmount.text = "$\(houses.amount) /month"
        if (houses.status != nil) == true {
            cell.houseStatus.text = "Booked"
            cell.houseStatus.textColor = UIColor.red
        } else {
            cell.houseStatus.textColor = UIColor.green
            cell.houseStatus.text = "Available"
        }
        
        if let imageData = houses.image {
            if let image = UIImage(data: imageData) {
                cell.imageLabel.image = image
            }
        }
        cell.cellStackView.layer.cornerRadius = 5
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowOpacity = 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}
