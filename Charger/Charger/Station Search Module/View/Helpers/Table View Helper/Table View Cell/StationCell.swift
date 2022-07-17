//
//  StationCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 12.07.2022.
//


import UIKit

class StationCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ACDCImageView: UIImageView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var serviceHoursLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var avaliableSocketNumberLabel: UILabel!
    
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
extension StationCell {
    
    // MARK: - setupUI
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
