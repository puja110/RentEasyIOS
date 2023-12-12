//
//  FavoriteTableViewController.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-11-02.
//

import UIKit
import CoreData



class FavoriteTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoritesTitle: UILabel!
    var buttonTextField = Button_FieldStyle()
    var dataModelManager = DataModelManager()
    var rentDataEntityProperty: [RentDataEntity] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        rentDataEntityProperty = DataModelManager.shared.loadFavouriteItems()
        tableView.reloadData()
        favoritesTitle.isHidden = rentDataEntityProperty.isEmpty ? true : false
        tableView.backgroundView = rentDataEntityProperty.isEmpty ? buttonTextField.emptyCheck(with: "No favorite property") : nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rentDataEntityProperty = DataModelManager.shared.loadFavouriteItems()
        let cellNib = UINib(nibName: "RentCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomCell")
    }
}

//MARK: -  TableView Delegate
extension FavoriteTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRentData = rentDataEntityProperty[indexPath.row]
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailPageID") as? DetailPageViewController {
            destinationVC.selectedItem = selectedRentData
            destinationVC.favorite = selectedRentData.isFavorite
            navigationController?.pushViewController(destinationVC, animated: true)
        } else {
            print("Failed.")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
}



//MARK: -  DataSource
extension FavoriteTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentDataEntityProperty.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! RentCell
        let favoriteHouses = rentDataEntityProperty[indexPath.row]
        cell.propertyName.text = favoriteHouses.name
        if let imageData = favoriteHouses.image {
            if let image = UIImage(data: imageData) {
                cell.propertyImage.image = image
            }
        }
        if favoriteHouses.bookedItem == true {
            cell.rentStatus.textColor = UIColor.red
            cell.rentStatus.text = "Booked"
        } else {
            cell.rentStatus.textColor = UIColor.green
            cell.rentStatus.text = "Available"
        }
        
        cell.propertyAmount.text = "$\(favoriteHouses.amount) /month"
        cell.propertyAddress.text = favoriteHouses.address
        cell.propertySize.text = favoriteHouses.type 
        let image = UIImage(systemName: "heart.fill")
        cell.favoriteButton.setImage(image, for: .normal)
        return cell
    }
}
