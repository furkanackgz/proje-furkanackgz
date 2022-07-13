//
//  FilterCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 13.07.2022.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterChoiceLabel: UILabel!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var cancelFilterButton: UIButton!
    
    // MARK: - Properties
    var stationSearchPresenter: StationSearchContract.stationSearchPresenter!
    
    // Filter choice property will be used for identifying
    // the particular filter cell that wished to be deleted
    var filterChoice: Filter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set up ui components
        setupUI()
        
    }
    
    // MARK: - didPressCancelFilterButton
    @IBAction func didPressCancelFilterButton(_ sender: Any) {
        
        // Unwrap selected filter cell info
        guard let filterChoice = filterChoice else { return }
        
        // Call did press cancel filter button method in presenter
        // with selected filter cell info
        stationSearchPresenter.didPressCancelFilterButton(with: filterChoice)
    }
    
}

// Setting up ui components
extension FilterCell {
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set container view
        setContainerView()
        
        // Set filter choice label
        setFilterChoiceLabel()
        
        // Set separator label
        separatorLabel.textColor = ThemeManager.color.title
        
        // Set cancel filter button
        cancelFilterButton.tintColor = ThemeManager.color.title
    }
    
    // MARK: - setContainerView
    private func setContainerView() {
        
        // Set container view background
        containerView.backgroundColor = ThemeManager.color.chosenCellBackground
        
        // Set container view layer
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = ThemeManager.color.chosenCellBorder?.cgColor
        
    }
    
    // MARK: - setFilterChoiceLabel
    private func setFilterChoiceLabel() {
        
        // Set filter choice label attributes
        filterChoiceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        filterChoiceLabel.textColor = ThemeManager.color.title
        
    }

    
}
