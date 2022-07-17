//
//  PickDateAndTimeService.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import Foundation

class PickDateAndTimeService {
    
    /*
     Set run constant as static for accessing it
     without initialization of the class.
    */
    static let run = PickDateAndTimeService()
    private let session = URLSession.shared
    
}

// Send station info request
extension PickDateAndTimeService {
    
    func sendStationInfoRequest(with stationID: Int , and date: String,
                                _ handler:@escaping (Data?) -> (Void)) {
        
        var endPoint = ""
        
        // Add station id as path variable
        endPoint.append("/\(stationID)")
        
        // Take user id from user defaults
        let userID = UserDefaults.standard.integer(forKey: "userID")
        
        // Add userID as query parameter
        endPoint.append("?userID=\(userID)")
        
        // Add date as query parameter
        endPoint.append("&date=\(date)")
        
        // Assign base url as string
        let baseURL = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations"
        
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
