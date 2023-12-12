//
//  DataModelManager.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-11-11.
//

import CoreData
import UIKit
import Foundation

class DataModelManager {
    
    static let shared = DataModelManager()
    init() {}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - SAVE CONTEXT
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
    }
    
    //MARK: - LOAD ALL ITEMS
    func loadAllItems() -> [RentDataEntity] {
        let request: NSFetchRequest<RentDataEntity> = RentDataEntity.fetchRequest()
        
        do {
            let fetchItems = try context.fetch(request)
            return fetchItems
        } catch {
            print("Error fetching")
        }
        return []
    }
    
    //MARK: - LOAD CATEGORY ITEMS
    func loadCategoryItems(for type: String?) -> [RentDataEntity] {
        let request: NSFetchRequest<RentDataEntity> = RentDataEntity.fetchRequest()
        if let type = type {
            let predicate = NSPredicate(format: "type == %@", type)
            request.predicate = predicate
        }
        
        do {
            let fetchItems = try context.fetch(request)
            return fetchItems
        } catch {
            print("Error fetching")
        }
        return []
    }
    
    //MARK: - LOAD POSTED ITEMS
    func loadPostedItems() -> [RentDataEntity] {
        let request: NSFetchRequest<RentDataEntity> = RentDataEntity.fetchRequest()
        request.predicate = NSPredicate(format: "postedItem == true")
        
        do {
            let fetchItems = try context.fetch(request)
            return fetchItems
        } catch {
            print("Error")
            return []
        }
    }
    
    //MARK: - LOAD BOOKED ITEMS
    func loadBookedItems() -> [RentDataEntity] {
        let request: NSFetchRequest<RentDataEntity> = RentDataEntity.fetchRequest()
        request.predicate = NSPredicate(format: "bookedItem == true")
        
        do {
            let fetchItems = try context.fetch(request)
            return fetchItems
        } catch {
            print("Error")
            return []
        }
    }
    
    //MARK: - LOAD FAVOURITE ITEMS
    func loadFavouriteItems() -> [RentDataEntity] {
        let request: NSFetchRequest<RentDataEntity> = RentDataEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == true")
        
        do {
            let fetchItems = try context.fetch(request)
            return fetchItems
        } catch {
            print("Error")
            return []
        }
    }
    
    //MARK: - SLIDER FETCH REQUEST
    
    func sliderAndPropertyTypeSearch(sliderAmount: Int, propertyType: String) -> [RentDataEntity] {
        let fetchRequest: NSFetchRequest<RentDataEntity> = RentDataEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "amount <= %d AND type CONTAINS[c] %@", sliderAmount, propertyType)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch {
            return []
        }
    }
    
    //MARK: - DELETING ITEMS
    func deleteItem(_ item: RentDataEntity) {
        context.delete(item)
        saveContext()
    }
    
    //MARK: - USER REGISTRATION
    func userRegistration(email: String, password: String, firstName: String, lastName: String, phoneNumber: String, context: NSManagedObjectContext) {
        
        let newUser = UserDetails(context: context)
        newUser.emailAddress = email
        newUser.password = password
        newUser.phoneNumber = phoneNumber
        newUser.firstName = firstName
        newUser.lastName = lastName
        do {
            try context.save()
            print("saved successfully")
        } catch {
            print("registration error")
        }
    }
    
    //MARK: - USER PROFILE UPDATE
    func userProfileUpdate(email: String, firstName: String, lastName: String, phoneNumber: String) {
        let request: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        do {
            let userInfo = try context.fetch(request)
            for user in userInfo {
                user.emailAddress = email
                user.phoneNumber = phoneNumber
                user.firstName = firstName
                user.lastName = lastName
            }
            saveContext()
        } catch {
            print("Error")
        }
        
    }
    
    //MARK: - USER PASSWORD UPDATE
    func userPasswordUpdate(password: String) {
        let request: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        do {
            let userInfo = try context.fetch(request)
            for user in userInfo {
                user.password = password
            }
            saveContext()
        } catch {
            print("Error Updating user password")
        }
        
    }
    
    
    
    //MARK: - USER LOGIN
    func userLogin(emailAddress: String, password: String) -> Bool {
        let request: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        request.predicate = NSPredicate(format: "emailAddress == %@", emailAddress)
        
        do {
            let users = try context.fetch(request)
            if let user = users.first, user.password == password {
                print("Login Successful")
                return true
            } else {
                print("Login Failed")
                return false
            }
        } catch {
            print("No User Found")
            return false
        }
    }
    
    
    //MARK: - Fetching UserDetails
    
    func fetchUserDetails() -> UserDetails? {
        let request: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        
        do {
            let userDetails = try context.fetch(request)
            return userDetails.first
        } catch {
            print("Error")
            return nil
        }
    }
    
    //MARK: - UploadData
    func uploadRentDataEntity(name: String, address : String, longitude: Double, latitude: Double, amount: Int, size: String, newImage: Data?, description: String) {
        let uploadData = RentDataEntity(context: context)
        uploadData.name = name
        uploadData.amount = Int16(amount)
        uploadData.type = size
        uploadData.image = newImage
        uploadData.itemDescription = description
        uploadData.postedItem = true
        uploadData.address = address
        uploadData.latitude = latitude
        uploadData.longitude = longitude
        
        saveContext()
        print("Saved Successfully")
    }
    
    //MARK: - DELETING USER
    func deleteUser() {
        let request: NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        do {
            let users = try context.fetch(request)
            for user in users {
                context.delete(user)
            }
            saveContext()
        } catch {
            print("Error deleting")
        }
    }
    
}
