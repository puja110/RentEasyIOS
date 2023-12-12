//
//  RentData.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-10-18.
//

import Foundation
import UIKit
import CoreData

struct RentData {
    let id: UUID
    let name: String
    let amount: Int
    let address: String
    let image: UIImage
    let status: String
    let size: String
    var favorite = false
    let longitude: Double
    let latitude: Double
    var testimonies: [Testimony]
    
    struct Testimony {
        let name: String
        let comment: String
    }
    init(id: UUID = UUID(), name: String, amount: Int, address: String, image: UIImage, status: String, size: String, longitude: Double, latitude: Double , testimonies: [Testimony]) {
        self.id = id
        self.name = name
        self.amount = amount
        self.address = address
        self.image = image
        self.status = status
        self.size = size
        self.longitude = longitude
        self.latitude = latitude
        self.testimonies = testimonies
    }
}


var property: [RentData] = [
    RentData(name: "Two Bedroom Flat", amount: 1000, address: "67 Sophia St", image: UIImage(imageLiteralResourceName: "houseOne"), status: "Available", size: "Condo", longitude: -79.68782193201106, latitude: 44.39393662891747,
             testimonies: [
                RentData.Testimony(name: "Adam Adam", comment: "This home is a true gem! It's a beautiful and inviting space that's perfect for creating lasting memories. You won't want to miss the chance to make this your new home"),
                RentData.Testimony(name: "John Legend", comment: "A true haven for those seeking a place to call home. This rental is not just beautiful; it's a slice of paradise that you can enjoy every day. Don't let this opportunity slip away!"),
                RentData.Testimony(name: "Emily Eva", comment: "Simply stunning! This home is an embodiment of beauty and comfort, offering a wonderful place to rent and create your own slice of paradise. Don't miss out on this delightful opportunity"),
                RentData.Testimony(name: "Taylor Swift", comment: "An exquisite home available for rent! This place is a perfect blend of elegance and warmth, and it's ready to become your new sanctuary. Grab this chance to experience the beauty of this lovely home."),
                RentData.Testimony(name: "Beyonce knowless", comment: "This home is a real treasure! It's not just a place to rent; it's a space where you can truly make memories and enjoy the beauty of everyday life. Don't hesitate to seize this fantastic opportunity") ]),
    
    
    RentData(name: "DownTown Mini House", amount: 2000, address: "98 Clapperton St", image: UIImage(imageLiteralResourceName: "houseTwo"), status: "Available", size: "Contemporary", longitude: -79.69177713358985, latitude: 44.394390537718486, testimonies: [RentData.Testimony(name: "Olasile Oladipupo", comment: "Wow, what a find! This home is an absolute beauty, offering a perfect blend of style and comfort. It's an excellent place to rent and create a warm, inviting atmosphere for yourself.")]),
    
    RentData( name: "Three Bedroom Condo", amount: 1200, address: "30 Wellington St E", image: UIImage(imageLiteralResourceName: "houseThree"), status: "Available", size: "Family Home", longitude: -79.69235078968296, latitude: 44.394841793994836, testimonies: [RentData.Testimony(name: "Puja Shresta", comment: "This home is a real treasure! It's not just a place to rent; it's a space where you can truly make memories and enjoy the beauty of everyday life. Don't hesitate to seize this fantastic opportunity")]),
    
    RentData(name: "Three bedroom Duplex", amount: 2000, address: "15 Grove St E", image: UIImage(imageLiteralResourceName: "houseFour"), status: "Available", size: "Contemporary", longitude: -79.69553627619078, latitude: 44.39710332221014, testimonies: [RentData.Testimony(name: "Pramod Regmi", comment: "A true haven for those seeking a place to call home. This rental is not just beautiful; it's a slice of paradise that you can enjoy every day. Don't let this opportunity slip away!")]),
    
    RentData(name: "Student Shared room", amount: 1300, address: "163A Owen St", image: UIImage(imageLiteralResourceName: "houseFive"), status: "Available", size: "Family Home", longitude: -79.69086939012152, latitude: 44.39692173565016, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Shared Home", amount: 1100, address: "Murray's Windermere Gardens", image: UIImage(imageLiteralResourceName: "houseOne"), status: "Available", size: "Family Home", longitude: -79.6883655062772, latitude: 44.395809210907245, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Single basement room", amount: 3000, address: "94 B Wellington St E", image: UIImage(imageLiteralResourceName: "houseSeven"), status: "Available", size: "Student Home", longitude:-79.68762335839357, latitude: 44.39699332946598, testimonies: [RentData.Testimony(name: "Name Name", comment: "Beautiful Home. Nice Place to live"), RentData.Testimony(name: "Name Name", comment: "Beautiful Home. Nice Place to live"),RentData.Testimony(name: "Name Name", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Two rooms shared", amount: 3000, address: "178 Owen St Unit I", image: UIImage(imageLiteralResourceName: "houseEight"), status: "Available", size: "Condo", longitude: -79.69239723365371, latitude: 44.39706848086475, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Three bedroom House", amount: 900, address: "67 Sophia Street E", image: UIImage(imageLiteralResourceName: "houseNine"), status: "Available", size: "Contemporary", longitude: -79.68791825808138, latitude: 44.394150275209235, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Rooftop view House", amount: 800, address: "36 Dalton St", image: UIImage(imageLiteralResourceName: "houseTen"), status: "Available", size: "Contemporary", longitude: -79.69770367777834, latitude: 44.39500855640846, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Shared condo House", amount: 1000, address: "50 Rodney St", image: UIImage(imageLiteralResourceName: "houseEleven"), status: "Available", size: "Family Home", longitude: -79.6717866301592, latitude: 44.3941049659377, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Rooftop Vista Quarters: Four Rooms & Three Bedrooms", amount: 700, address: "225 Cardinal St", image: UIImage(imageLiteralResourceName: "houseTwelve"), status: "Available", size: "Student Home", longitude: -79.6932893722218, latitude: 44.41529584868266, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Five rooms duplex", amount: 650, address: "28 Hadden Crescent", image: UIImage(imageLiteralResourceName: "houseThirteen"), status: "Available", size: "Condo", longitude: -79.69505963015818, latitude: 44.413410608155544, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Zenith Haven: Four-Room Rooftop Residence", amount: 800, address: "34 Roslyn Rd", image: UIImage(imageLiteralResourceName: "houseFourteen"), status: "Available", size: "Contemporary", longitude: -79.67701936560793, latitude: 44.40935186496082, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData( name: "Summit Sanctuary: Four-Room Skyline Home", amount: 700, address: "43 Davies Crescent", image: UIImage(imageLiteralResourceName: "houseFifteen"), status: "Available", size: "Family Home", longitude: -79.67076521746043, latitude: 44.40598136525225, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData( name: "Aerie Abode: Rooftop View & Three Bedrooms", amount: 900, address: "28 Belcourt Ave", image: UIImage(imageLiteralResourceName: "houseSixteen"), status: "Available", size: "Condo", longitude: -79.67367273201047, latitude: 44.405053932054386, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Elevated Elegance: Four-Room Rooftop House", amount: 1000, address: "8 Roslyn Rd", image: UIImage(imageLiteralResourceName: "houseSeventeen"), status: "Available", size: "Contemporary", longitude: -79.6794387460513, latitude: 44.40831562322177, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Horizon Heights: Three-Bedroom Rooftop Residence", amount: 1000, address: "1 Bernick Dr", image: UIImage(imageLiteralResourceName: "houseEighteen"), status: "Available", size: "Student Home", longitude: -79.67373327433832, latitude: 44.40900025689407, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Skyline Serenity: Four-Room Rooftop Home", amount: 1000, address: "8 Clarence Ct", image: UIImage(imageLiteralResourceName: "houseNineteen"), status: "Available", size: "Student Home", longitude: -79.67185695796127, latitude: 44.41021746186705, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")]),
    
    RentData(name: "Vista Haven: Rooftop Retreat & Three Bedrooms", amount: 1000, address: "71 Ruffet Dr", image: UIImage(imageLiteralResourceName: "houseTwenty"), status: "Available", size: "Contemporary", longitude: -79.68431852556925, latitude: 44.39578067302999, testimonies: [RentData.Testimony(name: "Manushi Khadka", comment: "Beautiful Home. Nice Place to live")])
    
]

//MARK: - CONVERTING RENTADA TO RENTDATAENTITY
extension RentData {
    static func rentdataSaveToCoreData(context: NSManagedObjectContext, rentDataObject: [RentData]) {
        for property in rentDataObject {
            if property.convertToCoreData(context: context) != nil {
                do {
                    try context.save()
                    print("saved")
                } catch {
                    print("Error saving")
                }
            }
        }
    }
    
    func convertToCoreData(context: NSManagedObjectContext) -> RentDataEntity? {
        let rentEntity = RentDataEntity(context: context)
        rentEntity.name = name
        rentEntity.amount = Int16(amount)
        rentEntity.address = address
        rentEntity.image = image.pngData()
        rentEntity.status = status
        rentEntity.type = size
        rentEntity.isFavorite = favorite
        rentEntity.latitude = latitude
        rentEntity.longitude = longitude
        return rentEntity
        
    }
}
