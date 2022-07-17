//
//  NotificationManager.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 28.06.2022.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    // Set singleton instance as static to access it using class name
    static let shared = NotificationManager()
    
    private var center: UNUserNotificationCenter?
    
    // Set init as private for preventing access from outside of class
    private init() {
        // Making Notification Manager ready to use
        setupNotificationManager()
    }
    
}

// MARK: - Asking permission to display local notifications at notification center
extension NotificationManager {
    
    private func setupNotificationManager() {
        center = UNUserNotificationCenter.current()
    }
    
    /**
     Requesting authorization with interaction types given and
     depending on what the completion handler gives an error or
     not it takes an action according to that.
     
     - parameter options: It holds the interactions types in an
     array
     - returns: none
     */
    func requestAuthorization() {
        center?.requestAuthorization(options: [.alert, .sound],
                                     completionHandler: { granted, error in
            
            // An error occured about getting permission for displaying notification
            if let error = error {
                print(error)
            }
            
        })
    }
}


// MARK: - Scheduling local notifications at notification center
extension NotificationManager {
    
    /**
     Before scheduling local notifications, always check for app's current
     authorization status. Because the user might change it any time.
     
     - parameter setting: It holds the current authorization status
     
     - returns: none
     */
    
    /*
     The completionHandler parameter might be added to the functions in terms of
     displaying notifications in view controller where this function is called
    */
    func scheduleNotification() {
        center?.getNotificationSettings(completionHandler: { settings in
            
            if settings.authorizationStatus == .authorized {
                // Schedule a notification at the center
            } else {
                // Ask user whether he/she wants to go to settings
            }
        })
    }
}
