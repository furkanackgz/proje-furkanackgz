//
//  AppointmentDetailsService.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import Foundation

class AppointmentDetailsService {
    
    /*
     Set run constant as static for accessing it
     without initialization of the class.
    */
    static let run = AppointmentDetailsService()
    private let session = URLSession.shared
    
}

// Send appointment request
extension AppointmentDetailsService {
    
    func sendAppointmentRequest(with appointmentRequest: Data,
                                _ handler:@escaping (Bool)->(Void) ) {
        
        var endPoint = ""
        
        // Take user id from user defaults
        let userID = UserDefaults.standard.integer(forKey: "userID")
        endPoint.append("?userID=\(userID)")
        
        // If user allowed the app, to get her/his location, add it to endPoint
        if let lastLocation  = LocationManager.shared.lastLocation {
            
            // Add latitude
            let latitude = lastLocation.latitude
            endPoint.append("&userLatitude=\(latitude)")
            
            // Add longitude
            let longitude = lastLocation.longitude
            endPoint.append("&userLongitude=\(longitude)")
            
        }
        
        // Assing base url as string
        let baseURL = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/make"
        
        // Assign whole url as URL object and check if
        // url is valid and proceed according to that
        if let url = URL(string: baseURL + endPoint) {
            
            // Take token from user defaults
            let token = UserDefaults.standard.string(forKey: "token")
            
            // Create URLRequest object with the url constant
            var urlRequest = URLRequest(url: url)
            
            // Add token value to token key in header
            urlRequest.setValue(token, forHTTPHeaderField: "token")
            
            // Set http method as post
            urlRequest.httpMethod = "POST"
            
            // Add appointment request to url request body
            urlRequest.httpBody = appointmentRequest
            
            // Start data task to the server with request object
            let task = session.dataTask(with: urlRequest) { data, response, error in
                
                // If error received, print it and assign handler as false
                if let error = error {
                    print(error)
                    return handler(false)
                }
                
                // If response has status code of 200 or the similar
                // ok value then proceed, otherwise finalize the process
                // and assign handler as false
                guard let response = response as? HTTPURLResponse,
                      200..<300 ~= response.statusCode else { return handler(false) }
                
                // If data is received, send back to interactor layer
                if let _ = data {
                    handler(true)
                }
                
            }
            task.resume()
        }
        
    }
    
}
