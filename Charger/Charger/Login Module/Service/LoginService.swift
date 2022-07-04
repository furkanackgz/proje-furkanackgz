//
//  LoginService.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import Foundation

class LoginService {
    /*
     Set both of variables as static for accessing them
     without initialization of the class.
    */
    static let run = LoginService()
    private let session = URLSession.shared
}

// MARK: - Send Login Request
extension LoginService {
    
    func sendLoginRequest(with requestData: Data,
                          and handler:@escaping ((Data?) -> (Void)) ) {
        
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login") else { return }
        
        // Create url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData
        
        let task = session.dataTask(with: request) { data, response, error in
            
            // If response code is 200, we can proceed
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return }
            
            // Send data back to interactor layer for decoding
            if let data = data {
                handler(data)
            }
            
        }
        task.resume()
    }
    
}
