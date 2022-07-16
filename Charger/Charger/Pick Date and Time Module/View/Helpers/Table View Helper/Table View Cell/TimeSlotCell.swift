//
//  TimeSlotCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 16.07.2022.
//

import UIKit

class TimeSlotCell: UITableViewCell {

    @IBOutlet private(set) weak var containerView: UIView!
    @IBOutlet private(set) weak var timeSlotLabel: UILabel!
    
    // MARK:  Properties
    var socketID: Int?
    var slot: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set up ui components
        setupUI()
        
        // Add self as notification center observer for
        // another cell selection
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectTimeSlot(_:)),
                                               name: .timeSlotSelected,
                                               object: nil)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

// Setting up ui components
extension TimeSlotCell {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set content view
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 4
        
        // Set time slot label
        timeSlotLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
    }
    
}

// @objc methods
extension TimeSlotCell {
    
    /**
     When another cell selected change cell's background
     and border color if selected.
     
     returns: None
     */
    // MARK: - didSelectAnotherCell
    @objc func didSelectTimeSlot(_ notification: Notification) {
        
        // Unwrap all the required properties
        guard let userInfo = notification.userInfo else { return }
        
        guard let socketID = userInfo["socketID"] as? Int else { return }
        
        guard let slot = userInfo["slot"] as? String else { return }
        
        guard let cellSocketID = self.socketID else { return }
        
        guard let cellSlot = self.slot else { return }
        
        // If selected slot's socket id and slot is the not the same
        // with this slot then change this cell's background and border
        // color back to default
        if !(socketID == cellSocketID && slot == cellSlot) {
            
            // Change container view's background and cell color
            // back to default
            containerView.backgroundColor = ThemeManager.color.accent
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = ThemeManager.color.accent?.cgColor
            
        }
        
        
        
    }
    
}
