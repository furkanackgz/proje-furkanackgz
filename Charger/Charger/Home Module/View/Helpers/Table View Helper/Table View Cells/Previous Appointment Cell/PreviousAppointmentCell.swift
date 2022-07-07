//
//  PreviousAppointmentCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 6.07.2022.
//

import UIKit

class PreviousAppointmentCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ACDCImageView: UIImageView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var kWhLabel: UILabel!
    @IBOutlet weak var socketNumberLabel: UILabel!
    @IBOutlet weak var socketTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set up ui components
        setupUI()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PreviousAppointmentCell {
    
    private func setupUI() {
        
        // Set content view
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view
        containerView.backgroundColor = ThemeManager.color.accent
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        
        // AC DC image view
        ACDCImageView.contentMode = .scaleAspectFit
        
    }
    
}
