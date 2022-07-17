//
//  AppointmentRequest.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 15.07.2022.
//

import Foundation

struct AppointmentRequest: Encodable {
    var stationID: Int?
    var socketID: Int?
    var timeSlot: String?
    var appointmentDate: String?
}
