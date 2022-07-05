//
//  Appointment.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 5.07.2022.
//

import Foundation

/*
 This is the data type which is received from
 server as a response to requesting appointments.
 */
struct Appointment: Decodable {
    let time: String?
    let date: String?
    let station: Station?
    let stationCode: String?
    let stationName: String?
    let userID: Int?
    let appointmentID: Int?
    let socketID: Int?
    let hasPassed: Bool?
}

// Property of appointment
struct Station: Decodable {
    let id: Int?
    let stationCode: String?
    let sockets: [Socket]?
    let socketCount: Int?
    let occupiedSocketCount: Int?
    let distanceInKM: Double?
    let geoLocation: GeoLocation?
    let services: [String]?
    let stationName: String?
}

// Property of Station
struct Socket: Decodable {
    let socketID: Int?
    let socketType: String?
    let chargeType: String?
    let power: Int?
    let powerUnit: String?
    let socketNumber: Int?
}

// Property of Station
struct GeoLocation: Decodable {
    let longitude: Double?
    let latitude: Double?
    let province: String?
    let address: String?
}
