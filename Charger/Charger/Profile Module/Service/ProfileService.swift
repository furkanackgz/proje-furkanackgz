//
//  ProfileService.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 10.07.2022.
//

import Foundation

class ProfileService {
    
    /*
     Set run variable as static for accessing it
     without initialization of the class.
    */
    static let run = ProfileService()
    private let session = URLSession.shared

    
}

// MARK: - sendLogoutRequest
extension ProfileService {
    
    /**
     This method sends logout request to the server, If the
     response from server has status code of 200, send true
     with completion handler object. If the response has other
     status codes, send false.
     
     parameter handler: Completion handler which is executed
     after this method completes its execution.
     returns: none
    */
    func sendLogoutRequest(_ handler:@escaping (Bool) -> (Void)) {
        
        var endPoint = ""
        
        // Take user id from user defaults
        let userID = UserDefaults.standard.integer(forKey: "userID")
        endPoint.append("/\(userID)")
        
        // Assing base url as string
        let baseURL = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/logout"
        
        // Assign whole url as URL object and check if
        // url is valid and proceed according to that
        if let url = URL(string: baseURL + endPoint) {
            
            // Take token from user defaults
            let token = UserDefaults.standard.string(forKey: "token")
            
            // Create URLRequest object with the url constant
            // and set http method to post
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            // Add token value to token key in header
            urlRequest.setValue(token, forHTTPHeaderField: "token")
            
            // Start data task to the server with request object
            
            let task = session.dataTask(with: urlRequest) { data, response, error in
                
                // If error received, print it and return false
                // in handler
                if let error = error {
                    print(error)
                    return handler(false)
                }
                
                // If response has status code of 200, return true
                // in handler, otherwise send false.
                if let response = response as? HTTPURLResponse,
                   response.statusCode == 200 {
                    // succeed
                    handler(true)
                } else {
                    // failure
                    handler(false)
                }
                
            }
            task.resume()
        }
        
    }
    
}


