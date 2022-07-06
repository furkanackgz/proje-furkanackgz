//
//  PreviousAppointmentCellHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 6.07.2022.
//

import UIKit

class PreviousAppointmentCellHelper: NSObject {
    
    private var appointments = [AppointmentType]()
    
    init(_ appointments: [AppointmentType]) {
        
        self.appointments = appointments
        
    }
    
}

// Previous appointment cell helper methods
extension PreviousAppointmentCellHelper {
    
    // MARK: - setACDCImageViewForPrevious
    func setACDCImageViewForPrevious(_ appointmentCell: PreviousAppointmentCell,
                                     _ indexPath: IndexPath) {
        var AC: Bool?
        var DC: Bool?
        
        // Get the sockets of the station
        guard let sockets = appointments[indexPath.section].appointments[indexPath.row].station?.sockets else { return }
        
        // Check whether station provides which type of charges
        sockets.forEach { socket in
            
            switch socket.chargeType {
            case "AC":
                AC = true
            case "DC":
                DC = true
            default:
                break
            }
            
        }
        
        // Station supports both type of charges
        if let _ = AC, let _ = DC{
            appointmentCell.ACDCImageView.image = ThemeManager.image.logoAcDc
        }
        // Station supports only AC type of charge
        else if let _ = AC {
            appointmentCell.ACDCImageView.image = ThemeManager.image.logoAc
        }
        // Station supports only DC type of charge
        else if let _ = DC {
            appointmentCell.ACDCImageView.image = ThemeManager.image.logoDC
        }
        
    }
    
    // MARK: - setStationNameLabelForPrevious
    func setStationNameLabelForPrevious(_ appointmentCell: PreviousAppointmentCell,
                                     _ indexPath: IndexPath) {
        // Unwrap station name variable
        guard let stationName = appointments[indexPath.section].appointments[indexPath.row].stationName else { return }
        
        appointmentCell.stationNameLabel.font = UIFont.systemFont(ofSize: 20,
                                                                         weight: .bold)
        appointmentCell.stationNameLabel.textColor = ThemeManager.color.title
        appointmentCell.stationNameLabel.text = stationName
    }
    
    // MARK: - setDateAndTimeLabelForPrevious
    func setDateAndTimeLabelForPrevious(_ appointmentCell: PreviousAppointmentCell,
                                     _ indexPath: IndexPath) {
        
        // Unwrap date variable
        guard let dateType = appointments[indexPath.section].appointments[indexPath.row].date else { return }

        // Convert date to appropriate format
        let date = convertNumeric(dateType)
        
        let dateAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: ThemeManager.color.title!
        ]
        let datePart = NSMutableAttributedString(string: "\(date), ", attributes: dateAttributes)
        
        // Unwrap time variable
        guard let time = appointments[indexPath.section].appointments[indexPath.row].time else { return }
        
        let timeAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: ThemeManager.color.title!
        ]
        let timePart = NSAttributedString(string: time, attributes: timeAttributes)
        
        // Concatenate date and time part
        datePart.append(timePart)

        // Assign concatenated part which is datePart to the label
        appointmentCell.dateAndTimeLabel.attributedText = datePart
        
    }
    
    
    /**
     Convert function takes and date string which is in
     numeric format such as 2022-06-23 and convert it to
     23 Jun 2022 and send it back.
     
     parameter numericDate: Numeric date in string format
     returns: Human readable date format
     */
    // MARK: - convertNumeric
    func convertNumeric(_ dateType: String) -> String {
        // Split the numeric date to year, month and day parts
        let partsOfDate = dateType.split(separator: "-")
        
        // Assign the parts
        let year = partsOfDate[0]
        let month = partsOfDate[1]
        let day = partsOfDate[2]
        
        let convertedMonth: String?
        
        // Look the month part and convert it
        switch month {
        case "01":
            convertedMonth = "Ocak"
        case "02":
            convertedMonth = "Şub"
        case "03":
            convertedMonth = "Mar"
        case "04":
            convertedMonth = "Nis"
        case "05":
            convertedMonth = "May"
        case "06":
            convertedMonth = "Haz"
        case "07":
            convertedMonth = "Tem"
        case "08":
            convertedMonth = "Ağus"
        case "09":
            convertedMonth = "Eyl"
        case "10":
            convertedMonth = "Ekim"
        case "11":
            convertedMonth = "Kas"
        case "12":
            convertedMonth = "Aral"
        default:
            convertedMonth = ""
        }
        
        // Return it in appropriate format
        return day + (convertedMonth ?? "") + year
    }
    
    // MARK: - setKWhLabelForPrevious
    func setKWhLabelForPrevious(_ appointmentCell: PreviousAppointmentCell,
                             _ indexPath: IndexPath) {
        
        // Unwrap sockets variable
        guard let sockets = appointments[indexPath.section].appointments[indexPath.row].station?.sockets else { return }
        
        // Unwrap the socketID
        guard let socketID = appointments[indexPath.section].appointments[indexPath.row].socketID else { return }
        
        var power: Int?
        var powerUnit: String?
        
        /*
         Find the socket we applied for and
         assign power and powerUnit variables
         according to that socket.
        */
        sockets.forEach { socket in
            if socket.socketID == socketID {
                power = socket.power
                powerUnit = socket.powerUnit
            }
        }
        
        // Assign power and powerUnit to the kWhLabel in the cell
        appointmentCell.kWhLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        appointmentCell.kWhLabel.text = "\(power ?? 0) \(powerUnit ?? "")"
        appointmentCell.kWhLabel.textColor = ThemeManager.color.title
        
    }
    
    // MARK: - setSocketNumberLabelForPrevious
    func setSocketNumberLabelForPrevious(_ appointmentCell: PreviousAppointmentCell,
                                      _ indexPath: IndexPath) {
        
        // Unwrap sockets variable
        guard let sockets = appointments[indexPath.section].appointments[indexPath.row].station?.sockets else { return }
        
        // Unwrap the socketID
        guard let socketID = appointments[indexPath.section].appointments[indexPath.row].socketID else { return }
        
        var socketNumber: Int?
        
        /*
         Find the socket we applied for and
         assign socketNumber variable
         according to that socket.
        */
        sockets.forEach { socket in
            if socket.socketID == socketID {
                socketNumber = socket.socketNumber
            }
        }
        
        // Assign socketNumber to the socketNumberLabel in the cell
        appointmentCell.socketNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        appointmentCell.socketNumberLabel.text = "Soket numarası: \(socketNumber ?? 0)"
        appointmentCell.socketNumberLabel.textColor = ThemeManager.color.title
        
    }
    
    // MARK: - setSocketTypeLabelForPrevious
    func setSocketTypeLabelForPrevious(_ appointmentCell: PreviousAppointmentCell,
                                    _ indexPath: IndexPath) {
        
        // Unwrap sockets variable
        guard let sockets = appointments[indexPath.section].appointments[indexPath.row].station?.sockets else { return }
        
        // Unwrap the socketID
        guard let socketID = appointments[indexPath.section].appointments[indexPath.row].socketID else { return }
        
        var chargeType: String?
        var socketType: String?
        
        /*
         Find the socket we applied for and
         assign chargeType and socketType
         variables according to that socket.
        */
        sockets.forEach { socket in
            if socket.socketID == socketID {
                chargeType = socket.chargeType
                socketType = socket.socketType
            }
        }
        
        // Assign chargeType and socketType to the socketTypeLabel in the cell
        appointmentCell.socketTypeLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        appointmentCell.socketTypeLabel.text = (chargeType ?? "") + " • " + (socketType ?? "")
        appointmentCell.socketTypeLabel.textColor = ThemeManager.color.title
    }
    
}
