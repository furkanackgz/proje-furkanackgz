//
//  AppointmentInformationsCellHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class AppointmentInformationsCellHelper: NSObject {
    
    // MARK: - Properties
    private var sectionDetail = [RowDetail]()
    
    private var appointmentInformationsCell: AppointmentInformationsCell!
    
    private var indexPath: IndexPath!
    
    // MARK: - init
    init(_ sectionDetail: [RowDetail],
         _ appointmentInformationsCell: AppointmentInformationsCell,
         _ indexPath: IndexPath) {
        
        super.init()
        
        // Assign properties came from table view hellper
        self.sectionDetail = sectionDetail
        self.appointmentInformationsCell = appointmentInformationsCell
        self.indexPath = indexPath
        
    }
    
}

// Self related methods
extension AppointmentInformationsCellHelper {
    
    // MARK: - setDateStack
    func setDateStack() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        
        // Set data title label
        cell.dateTitleLabel.text = sectionDetail.rowTitle
        cell.dateTitleLabel.textColor = ThemeManager.color.title
        cell.dateTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                     weight: .bold)
        
        // Set data value label
        cell.dateValueLabel.text = sectionDetail.rowValue
        cell.dateValueLabel.textColor = ThemeManager.color.subtitle
        cell.dateValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                     weight: .regular)
        
    }
    
    // MARK: - setHourStack
    func setHourStack() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set hour title label
        cell.hourTitleLabel.text = sectionDetail.rowTitle
        cell.hourTitleLabel.textColor = ThemeManager.color.title
        cell.hourTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                     weight: .bold)
        
        // Set hour value label
        cell.hourValueLabel.text = sectionDetail.rowValue
        cell.hourValueLabel.textColor = ThemeManager.color.subtitle
        cell.hourValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                     weight: .regular)
        
    }
    
    // MARK: - setAppointmentDurationStack
    func setAppointmentDurationStack() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set appointment duration title label
        cell.appointmentDurationTitleLabel.text = sectionDetail.rowTitle
        cell.appointmentDurationTitleLabel.textColor = ThemeManager.color.title
        cell.appointmentDurationTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                                    weight: .bold)
        
        // Set appointment duration value label
        cell.appointmentDurationValueLabel.text = "1 Saat"
        cell.appointmentDurationValueLabel.textColor = ThemeManager.color.subtitle
        cell.appointmentDurationValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
    }
    
    // MARK: - setGetNotificationTitleLabel
    func setGetNotificationTitleLabel() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        let sectionDetail = sectionDetail[indexPath.row]
        
        // Set get notification title label
        cell.getNotificationTitleLabel.text = sectionDetail.rowTitle
        cell.getNotificationTitleLabel.textColor = ThemeManager.color.title
        cell.getNotificationTitleLabel.font = UIFont.systemFont(ofSize: 18,
                                                                weight: .bold)
        
    }
    
    // MARK: - setSwitchOn
    func setSwitchOn() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        // Set switch on
        cell.notificationSwitch.setOn(true, animated: true)
        
        // Set switch on image
        cell.notificationSwitch.onImage = ThemeManager.image.switchOn
    
    }
    
    // MARK: - setSwitchOff
    func setSwitchOff() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        // Set switch off
        cell.notificationSwitch.setOn(false, animated: true)
        
        // Set switch off image
        cell.notificationSwitch.offImage = ThemeManager.image.switchOff
        
    }
    
    // MARK: - displayDropDownStack
    func displayDropDownStack() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        // Display drown down
        cell.dropDownStackView.isHidden = false
        
    }
    
    // MARK: - hideDropDownStack
    func hideDropDownStack() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        // Hide drop down
        cell.dropDownStackView.isHidden = true
        
    }
    
    // MARK: - setDropDownStack
    func setDropDownStack() {
        
        guard let cell = appointmentInformationsCell else { return }
        
        // Set time picker title label
        cell.timePickerValueLabel.text = "Zamanlayıcı Seç"
        cell.timePickerValueLabel.textColor = ThemeManager.color.title
        cell.timePickerValueLabel.font = UIFont.systemFont(ofSize: 18,
                                                           weight: .regular)
        
        // Set down arrow label
        cell.downArrowLabel.text = "v"
        cell.downArrowLabel.textColor = ThemeManager.color.title
        cell.downArrowLabel.font = UIFont.systemFont(ofSize: 18,
                                                     weight: .regular)
        
    }
    
}
