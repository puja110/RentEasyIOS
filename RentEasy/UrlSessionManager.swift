//
//  URL_Session_Manager.swift
//  RentEasy
//
//  Created by CodeSOMPs on 2023-11-15.
//

import Foundation

struct UrlSessionManager {
    
    //MARK: - R - FETCHING DATA
    func performFetchingRequest() {
        let urlString = "API"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error  in
                
                if error != nil {
                    print("Error \(String(describing: error?.localizedDescription))")
                    return
                }
                if let safeData = data {
                    let rentalModel = self.decodeRentData(from: safeData)
                    print("fetched data \(String(describing: rentalModel))")
                }
            }
            task.resume()
        }
    }
    
    func decodeRentData(from data: Data) -> UrlSessionRentData? {
        do {
            let decoder = JSONDecoder()
            let rentalModel = try decoder.decode(UrlSessionRentData.self, from: data)
            return rentalModel
        } catch {
            print("Error decoding data")
            return nil
        }
    }
    
    
    //MARK: - C - CREATING DATA
    
    func postRequest(postData: Data) {
        let urlString = "API"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    print("Error \(String(describing: error?.localizedDescription))")
                    return
                }
                if let responseData = data {
                    let responseString = String(data: responseData, encoding: .utf8)
                    print("Server response \(String(describing: responseString))")
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: - D - DELETING DATA
    
    func deleteRequest() {
        let urlString = "API"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                    return
                }
                if let responseData = data {
                    let responseString = String(data: responseData, encoding: .utf8)
                    print("Server response \(String(describing: responseString))")
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: - USER REGISTRATION
    
    func createUser(user: UserInformation) {
        let urlString = "API"
        guard let jsonData = try? JSONEncoder().encode(user) else {
            print("Failed to encode ")
            return
        }
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                    return
                }
                if let responseData = data {
                    let responseString = String(data: responseData, encoding: .utf8)
                    print("Server response \(String(describing: responseString))")
                }
            }
            
            task.resume()
        }
    }
}

