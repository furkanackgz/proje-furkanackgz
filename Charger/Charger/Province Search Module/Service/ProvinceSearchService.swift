//
//  ProvinceSearchService.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 11.07.2022.
//

import Foundation

class ProvinceSearchService {
    
    /*
     Set run constant as static for accessing it
     without initialization of the class.
    */
    static let run = ProvinceSearchService()
    private let session = URLSession.shared
    
}

// MARK: - Send Provinces Request
extension ProvinceSearchService {
    
    func sendProvincesRequest(_ handler:@escaping (Data?) -> (Void)) {
        
        var endPoint = ""
        
        // Take user id from user defaults
        let userID = UserDefaults.standard.integer(forKey: "userID")
        endPoint.append("?userID=\(userID)")
        
        // Assing base url as string
        let baseURL = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/provinces"
        
        // Assign whole url as URL object and check if
        // url is valid and proceed according to that
        if let url = URL(string: baseURL + endPoint) {
            
            // Take token from user defaults
            let token = UserDefaults.standard.string(forKey: "token")
            
            // Create URLRequest object with the url constant
            var urlRequest = URLRequest(url: url)
            
            // Add token value to token key in header
            urlRequest.setValue(token, forHTTPHeaderField: "token")
            
            // Start data task to the server with request object
            let task = session.dataTask(with: urlRequest) { data, response, error in
                
                // If error received, print it and finalize the process
                if let error = error { return print(error) }
                
                // If response has status code of 200 or the similar
                // ok value then proceed, otherwise finalize the process
                guard let response = response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else { return }
                
                // If data is received, send back to interactor layer
                if let data = data {
                    handler(data)
                }
                
            }
            task.resume()
        }

        
    }
    
}
