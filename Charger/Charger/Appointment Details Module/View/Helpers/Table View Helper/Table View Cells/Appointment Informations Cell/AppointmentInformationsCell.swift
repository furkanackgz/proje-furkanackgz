//
//  AppointmentInformationsCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class AppointmentInformationsCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var dateValueLabel: UILabel!
    @IBOutlet weak var hourTitleLabel: UILabel!
    @IBOutlet weak var hourValueLabel: UILabel!
    @IBOutlet weak var appointmentDurationTitleLabel: UILabel!
    @IBOutlet weak var appointmentDurationValueLabel: UILabel!
    @IBOutlet weak var getNotificationTitleLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var dropDownStackView: UIStackView!
    @IBOutlet weak var timePickerValueLabel: UILabel!
    @IBOutlet weak var downArrowLabel: UILabel!
    
    // MARK: - Properties
    var appointmentDetailsPresenter: AppointmentDetailsContract.appointmentDetailsPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set up ui componenets
        setupUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didChangeSwitchState(_ sender: Any) {
        
        // If switch's state change then let presenter know
        appointmentDetailsPresenter.didChangeSwitchState()
        
    }
    
}

// Setting up ui components
extension AppointmentInformationsCell {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set content view's background
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view's background
        containerView.backgroundColor = ThemeManager.color.accent
        
    }
    
}
