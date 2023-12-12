//
//  RentCell.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-10-17.
//

import UIKit

class RentCell: UITableViewCell {
    
    @IBOutlet weak var rentCustomCell: UIView!
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var rentStatus: UILabel!
    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var propertySize: UILabel!
    @IBOutlet weak var propertyAmount: UILabel!
    @IBOutlet weak var propertyImage: UIImageView!
    @IBOutlet weak var cellStackView: UIStackView!
    @IBOutlet weak var favoriteButton: UIButton!
    var buttonTextField = Button_FieldStyle()
    var indexPath: IndexPath?
    var tableView: UITableView?
    var houses: RentDataEntity? {
        didSet {
            guard let houses = houses else { return }
            updateButtonImage(isFavorite: houses.isFavorite)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        propertyImage.layer.cornerRadius = 5
        propertyImage.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.isSelected = false
    }

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let houses = houses else {
            print("returned")
            return
        }
        houses.isFavorite.toggle()
        DataModelManager.shared.saveContext()
        updateButtonImage(isFavorite: houses.isFavorite)
    }
    
    func updateButtonImage(isFavorite: Bool) {
           let imageName = isFavorite ? "heart.fill" : "heart"
           let image = UIImage(systemName: imageName)
           favoriteButton.setImage(image, for: .normal)
           favoriteButton.setImage(image, for: .selected)
       }
}
