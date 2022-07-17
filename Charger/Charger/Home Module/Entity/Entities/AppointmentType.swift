//
//  AppointmentType.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import Foundation

/*
 This is the data type which is used in table view
 where the appointments are displayed in home page.
*/
class AppointmentType {
    var name: String?
    var appointments = [Appointment]()
    
    /**
     parameter name: Indicates type of the appointment.
     
     paremeter currentAppointments: The array which the
     current appointments are held in.
     */
    init(name: String,
         appointments: [Appointment]) {
        
        self.name = name
        self.appointments = appointments
    }
}
