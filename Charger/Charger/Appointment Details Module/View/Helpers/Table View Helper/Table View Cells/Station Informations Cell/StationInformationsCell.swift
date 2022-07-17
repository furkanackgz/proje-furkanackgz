//
//  StationInformationsCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class StationInformationsCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var serviceHoursTitleLabel: UILabel!
    @IBOutlet weak var serviceHoursValueLabel: UILabel!
    @IBOutlet weak var distanceTitleLabel: UILabel!
    @IBOutlet weak var distanceValueLabel: UILabel!
    @IBOutlet weak var stationCodeTitleLabel: UILabel!
    @IBOutlet weak var stationCodeValueLabel: UILabel!
    @IBOutlet weak var servicesTitleLabel: UILabel!
    @IBOutlet weak var servicesValueLabel: UILabel!
    
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

// Setting up ui components
extension StationInformationsCell {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set content view's background
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view's background
        containerView.backgroundColor = ThemeManager.color.accent
        
    }
    
}
