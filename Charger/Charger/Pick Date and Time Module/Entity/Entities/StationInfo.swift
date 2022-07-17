//
//  StationInfo.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 15.07.2022.
//

import Foundation

// MARK: - StationInfo
struct StationInfo: Decodable {
    var stationID: Int?
    var stationCode: String?
    var sockets: [SocketInfo]?
    var geoLocation: GeoLocationInfo?
    var services: [String]?
    var stationName: String?
}

// MARK: - SocketInfo
struct SocketInfo: Decodable {
    var socketID: Int?
    var day: DayInfo?
    var socketType: String?
    var chargeType: String?
    var power: Int?
    var socketNumber: Int?
    var powerUnit: String?
}

// MARK: - DayInfo
struct DayInfo: Decodable {
    var id: Int?
    var date: String?
    var timeSlots: [TimeSlotInfo]?
}

// MARK: - TimeSlotInfo
struct TimeSlotInfo: Decodable {
    var slot: String?
    var isOccupied: Bool?
}

// MARK: - GeoLocationInfo
struct GeoLocationInfo: Decodable {
    var longitude: Double?
    var latitude: Double?
    var province: String?
    var address: String?
}
