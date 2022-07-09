//
//  HomeService.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import Foundation

class HomeService {
    
    /*
     Set run variable as static for accessing it
     without initialization of the class.
    */
    static let run = HomeService()
    private let session = URLSession.shared

}

// MARK: - Send Appointments Request
extension HomeService {
    
    func sendAppointmentsRequest(_ handler:@escaping (Data?) -> (Void) ) {
        
        var endPoint = ""
        
        // Take user id from user defaults
        let userID = UserDefaults.standard.integer(forKey: "userID")
        endPoint.append("/\(userID)")
        
        // If user allowed the app, to get her/his location, add it to endPoint
        if let lastLocation  = LocationManager.shared.lastLocation {
            
            // Add latitude
            let latitude = lastLocation.latitude
            endPoint.append("?userLatitude=\(latitude)")
            
            // Add longitude
            let longitude = lastLocation.longitude
            endPoint.append("&userLongitude=\(longitude)")
            
        }
        
        // Assing base url as string
        let baseURL = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments"
        
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

// MARK: - Send delete Appointment Request
extension HomeService {
    
    /**
     This method takes appointment id of an appointment
     and send delete request with it. If the response from
     server has status code of 200, send true with completion
     handler object handler. If the response has other status
     codes, send false.
     
     parameter appointmentID: Appointment id of particular
     appointments
     parameter handler: Completion handler which is executed
     after this method completes its execution.
     returns: none
    */
    func sendDeleteAppointmentRequest(with appointmentID: Int,
                           handler:@escaping (Bool) -> (Void)) {
        
        var endPoint = ""
        
        // Add appointment id as path variable
        endPoint.append("/\(appointmentID)")
        
        // Take user id from user defaults
        let userID = UserDefaults.standard.integer(forKey: "userID")
        endPoint.append("?userID=\(userID)")
        
        // Assign base url as string
        let baseURL = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/cancel"
        
        // Assign whole url as URL object and check if
        // url is valid and proceed according to that
        if let url = URL(string: baseURL + endPoint) {
            
            // Take token from user defaults
            let token = UserDefaults.standard.string(forKey: "token")
            
            // Create URLRequest object with the url constant
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            
            // Add token value to the token key in header
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
                    handler(false)
                }
                
            }
            task.resume()
        }

    }
    
}
