//
//  FilteredResultViewController.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-11-03.
//

import UIKit

class FilteredResultViewController: UIViewController {
    
    
    @IBOutlet weak var resultCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    var filteredRentData: [RentDataEntity] = [] {
           didSet {
               print(filteredRentData.count)
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RentCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        print(filteredRentData.count)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if filteredRentData.count <= 1 {
            resultCountLabel.text = "Showing \(filteredRentData.count) result."
        } else {
            resultCountLabel.text = "Showing \(filteredRentData.count) results."
        }
        tableView.reloadData()
    }
}

extension FilteredResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredRentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! RentCell
        let result = filteredRentData[indexPath.row]
        cell.propertyName.text = result.name
        if let imageData = result.image, let image = UIImage(data: imageData) {
            cell.propertyImage.image = image
        } else {
            cell.propertyImage.image = nil
        }
        cell.propertyAmount.text = "$\(result.amount) /month"
        cell.propertyAddress.text = result.address
        cell.rentStatus.text = result.status ?? "Available"
        cell.propertySize.text = result.type 
        cell.cellStackView.layer.cornerRadius = 5
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowOpacity = 1
        
        return cell
    }
    
    
}

extension FilteredResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRentData = filteredRentData[indexPath.row]
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailPageID") as? DetailPageViewController else {return}
        destinationVC.selectedItem = selectedRentData
        present(destinationVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
