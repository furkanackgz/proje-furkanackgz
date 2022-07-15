//
//  SliderTableViewCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 14.07.2022.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var slider: UISlider!
    
    // MARK: - Properties
    var filterType: String!
    var filterChoice: String!
    private var previousSliderValue: Int?
    var filteringPresenter: FilteringContract.filteringPresenter! {
        didSet {
            // After filtering presenter is assigned,
            // awake slider table view cell
            awakeSliderTableViewCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - didChangeSliderValue
    @IBAction func didChangeSliderValue(_ sender: Any) {
        
        // Take the current slider value from slider
        let currentSliderValue = Int(slider.value)
        
        // Update slider value in filter choices
        filteringPresenter.updateSliderValue(with: filterType,
                                             and: currentSliderValue)
        
    }
    
}

// Setting up ui components
extension SliderTableViewCell {
    
    // MARK: - awakeSliderTableViewCell
    private func awakeSliderTableViewCell() {
        
        // Check whether slider has previously set value
        previousSliderValue = filteringPresenter.checkWhetherSliderValueSet(with: filterType, and: filterChoice)
        
        // Set ui components
        setupUI()
        
        // Display slider as default or with previously set value
        displaySliderAsDefaultOrSet()
        
    }
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set views
        setViews()
        
        // Set slider
        setSlider()
        
    }
    
    // MARK: - setViews
    private func setViews() {
        
        // Set content view
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view's background color
        containerView.backgroundColor = ThemeManager.color.background
        
    }
    
    // MARK: - setSlider
    private func setSlider() {
        
        // Set min and max values
        slider.minimumValue = 3
        slider.maximumValue = 15
        
        // Set color of min and max track
        slider.minimumTrackTintColor = .systemGreen
        
    }
    
    // MARK: - displaySliderAsDefaultOrSet
    private func displaySliderAsDefaultOrSet() {
     
        // If slider value already set
        if let previousSliderValue = previousSliderValue {
            
            // Display it with already set value
            slider.value = Float(previousSliderValue)
            
        } else {
            
            // Display it as default
            slider.value = 15
            
        }
        
    }
    
}
