//
//  SocketInformationsCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 17.07.2022.
//

import UIKit

class SocketInformationsCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var socketNumberTitleLabel: UILabel!
    @IBOutlet weak var socketNumberValueLabel: UILabel!
    @IBOutlet weak var chargeTypeTitleLabel: UILabel!
    @IBOutlet weak var chargeTypeValueLabel: UILabel!
    @IBOutlet weak var socketTypeTitleLabel: UILabel!
    @IBOutlet weak var socketTypeValueLabel: UILabel!
    
    @IBOutlet weak var powerAndPowerUnitTitleLabel: UILabel!
    @IBOutlet weak var powerAndPowerUnitValueLabel: UILabel!
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
extension SocketInformationsCell {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set content view's background
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view's background
        containerView.backgroundColor = ThemeManager.color.accent
        
    }
    
}
