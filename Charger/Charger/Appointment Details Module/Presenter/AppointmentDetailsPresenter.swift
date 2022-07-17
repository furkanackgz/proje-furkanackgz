//
//  AppointmentDetailsPresenter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import Foundation

class AppointmentDetailsPresenter:
    AppointmentDetailsContract.appointmentDetailsPresenter {
    
    // MARK: - Properties
    var appointmentDetailsView: AppointmentDetailsContract.appointmentDetailsView!
    
    var appointmentDetailsInteractor: AppointmentDetailsContract.appointmentDetailsInteractor!
    
    var appointmentDetailsRouter: AppointmentDetailsContract.appointmentDetailsRouter!
    
}

// Self related
extension AppointmentDetailsPresenter {
    
    // MARK: - prepareAppointmentDetailsData
    private func prepareAppointmentDetailsData() -> [AppointmentDetail] {
        
        // Take prepared station informations
        let stationInformations = prepareStationInformations()
        
        // Take prepared socket informations
        let socketInformations = prepareSocketInformations()
        
        // Take prepared appointment informations
        let appointmentInformations = prepareAppointmentInformations()
        
        
        // Create appointment details object with the station info
        // came from pick date and time module
        let appointmentDetails: [AppointmentDetail] = [
            .init(sectionName: "İSTASYON BİLGİLERİ",
                  sectionDetail: [
                    .init(rowTitle: "Adres",
                          rowValue: stationInformations["Adres"]!),
                    .init(rowTitle: "Hizmet Saatleri",
                          rowValue: stationInformations["Hizmet Saatleri"]!),
                    .init(rowTitle: "Uzaklık",
                          rowValue: stationInformations["Uzaklık"]!),
                    .init(rowTitle: "İstasyon Kodu",
                          rowValue: stationInformations["İstasyon Kodu"]!),
                    .init(rowTitle: "Hizmetler",
                          rowValue: stationInformations["Hizmetler"]!)
                  ]),
            .init(sectionName: "SOKET BİLGİLERİ",
                  sectionDetail: [
                    .init(rowTitle: "Soket Numarası",
                          rowValue: socketInformations["Soket Numarası"]!),
                    .init(rowTitle: "Cihaz Tipi",
                          rowValue: socketInformations["Cihaz Tipi"]!),
                    .init(rowTitle: "Soket Tipi",
                          rowValue: socketInformations["Soket Tipi"]!),
                    .init(rowTitle: "Çıkış Gücü",
                          rowValue: socketInformations["Çıkış Gücü"]!)
                  ]),
            .init(sectionName: "RANDEVU BİLGİLERİ",
                  sectionDetail: [
                    .init(rowTitle: "Tarih",
                          rowValue: appointmentInformations["Tarih"]!),
                    .init(rowTitle: "Saat",
                          rowValue: appointmentInformations["Saat"]!),
                    .init(rowTitle: "Randevu Süresi",
                          rowValue: appointmentInformations["Randevu Süresi"]!),
                    .init(rowTitle: "Bildirim Al",
                          rowValue: appointmentInformations["Bildirim Al"]!),
                    .init(rowTitle: "",
                          rowValue: appointmentInformations[""]!)
                  ])
        ]
        
        return appointmentDetails
    }
    
    // MARK: - prepareStationInformations
    private func prepareStationInformations() -> [String:String] {
        
        // Take the station info from interactor layer
        guard let stationInfo = appointmentDetailsInteractor.stationInfo else { return [:] }
        
        // Unwrap address
        guard let address = stationInfo.geoLocation?.address else{ return [:] }
        
        // Unwrap distance
        
        // Unwrap station code
        guard let stationCode = stationInfo.stationCode else { return [:] }
        
        // Unwrap services
        guard let services = stationInfo.services else { return [:] }
        
        // Concatenate services
        let concatenatedServices = concatenateServices(services)
        
        let stationInformations: [String:String] = [
            "Adres": address,
            "Hizmet Saatleri": "24 Saat",
            "Uzaklık": "1 km",
            "İstasyon Kodu": stationCode,
            "Hizmetler": concatenatedServices,
        ]
        
        return stationInformations
    }
    
    // MARK: - concatenateServices
    private func concatenateServices(_ services: [String]) -> String {
        
        var concatenatedServices = ""
        
        for index in 0..<services.count {
            
            concatenatedServices.append(services[index])
            
            if index != (services.count - 1) {
                concatenatedServices.append(", ")
            }
            
        }
        
        return concatenatedServices
    }
    
    // MARK: - prepareSocketInformations
    private func prepareSocketInformations() -> [String:String] {
        
        // Take the station info from interactor layer
        guard let stationInfo = appointmentDetailsInteractor.stationInfo else { return [:] }
        
        // Get the socketID from appointment request came from pick date and
        // time module
        guard let socketID = appointmentDetailsInteractor.appointmentRequest?.socketID else { return [:] }
        
        var socketNumber = ""
        
        var chargeType = ""
        
        var socketType = ""
        
        var power = ""
        
        var powerUnit = ""
        
        // Find and initialize required properties in station info
        stationInfo.sockets?.forEach({ socket in
            
            // If socket id is the same with the appointment
            // request's socket id then assign requied properties
            // of socket informations with that socket properties
            if socket.socketID == socketID {
                
                socketNumber = "\(socket.socketNumber!)"
                chargeType = socket.chargeType!
                socketType = socket.socketType!
                power = "\(socket.power!)"
                powerUnit = socket.powerUnit!
                
            }
            
        })
        
        let socketInformations: [String:String] = [
            "Soket Numarası": socketNumber,
            "Cihaz Tipi": chargeType,
            "Soket Tipi": socketType,
            "Çıkış Gücü":"\(power) \(powerUnit)"
        ]
        
        return socketInformations
    }
    
    // MARK: - prepareAppointmentInformations
    private func prepareAppointmentInformations() -> [String:String] {
        
        // Take the appointment request from interactor layer
        guard let appointmentRequest = appointmentDetailsInteractor.appointmentRequest else { return [:] }
        
        let date = appointmentRequest.appointmentDate!
        
        let hour = appointmentRequest.timeSlot!

        
        let appointmentInformations: [String:String] = [
            "Tarih": date,
            "Saat": hour,
            "Randevu Süresi": "1 Saat",
            "Bildirim Al": "",
            "": ""
        ]
        
        return appointmentInformations
    }
    
}

// View related
extension AppointmentDetailsPresenter {
    
    // MARK: - viewDidLoad
    func viewDidLoad() {
        
        // Prepare appointment details data
        let appointmentDetails = prepareAppointmentDetailsData()
        
        // Call update appointment details table view method in view layer
        appointmentDetailsView.updateAppointmentDetailsTableView(with: appointmentDetails)
        
    }
    
    // MARK: - didChangeSwitchState
    func didChangeSwitchState() {
        
        
        
    }
    
    // MARK: - didSelectTimer
    func didSelectTimer(value: String) {
        
        
        
    }
    
    // MARK: - didPressRandevuyuOnaylaButton
    func didPressRandevuyuOnaylaButton(_ appointmentDetailsView: AppointmentDetailsView) {
        
        // Assign appointment details view to router layer
        // for using it to navigate back to home page
        appointmentDetailsRouter.appointmentDetailsView = appointmentDetailsView
        
        // Call interactor layer
        appointmentDetailsInteractor.sendAppointmentRequest()
        
    }
    
}


// Interactor related
extension AppointmentDetailsPresenter {
    
    // MARK: - didSendAppointmentRequest
    func didSendAppointmentRequest() {
        
        // Call navigate back to home page method in router layer
        // to navigate back to home page
        appointmentDetailsRouter.navigateBackToHomePage()
        
    }
    
    
}
