//
//  TableCollectionViewCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 14.07.2022.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var filterChoiceLabel: UILabel!
    
    // MARK: - Properties
    var filterType: String!
    var filterChoice: String!
    var isFilterCellSelected: Bool?
    var filteringPresenter: FilteringContract.filteringPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Check whether filter cell is selected before
        isFilterCellSelected = filteringPresenter.checkWhetherFilterCellSelected(with: filterType, and: filterChoice)
        
        // Display filter cell depending on isFilterSelected value
        displayFilterCellAsDefaultOrSelected()
            
        // Add tap gesture recogniser to container view
        addTapGestureRecognizerToContainerView()
        
    }

}

// Self related methods
extension TableCollectionViewCell {
    
    // MARK: - displayAsDefaultOrSelected
    private func displayFilterCellAsDefaultOrSelected() {
        
        // If filter cell is selected before
        if isFilterCellSelected! {
            
            // Display filter cell as selected
            displayFilterCellAsSelected()
            
        } else {
            
            // Display filter cell as default
            displayFilterCellAsDefault()
            
        }
        
    }
    
    // MARK: - displayFilterCellAsSelected
    private func displayFilterCellAsSelected() {
        
        // Set container view's background
        containerView.backgroundColor = ThemeManager.color.chosenCellBackground
        
        // Set container view's layer
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = ThemeManager.color.chosenCellBorder?.cgColor
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
        // Set filter choice label
        filterChoiceLabel.text = filterChoice
        filterChoiceLabel.textColor = ThemeManager.color.title
        
    }
    
    // MARK: - displayFilterCellAsDefault
    private func displayFilterCellAsDefault() {
        
        // Set container view's background
        containerView.backgroundColor = ThemeManager.color.background
        
        // Set container view's layer
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = ThemeManager.color.title?.cgColor
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
        // Set filter choice label
        filterChoiceLabel.text = filterChoice
        filterChoiceLabel.textColor = ThemeManager.color.title
        
    }
    
    // MARK: - addTapGestureRecognizerToContainerView
    private func addTapGestureRecognizerToContainerView() {
        
        // Create tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(didSelectFilter))
        
        // Assign tap gesture recognizer to the container view
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
}

// @objc methods
extension TableCollectionViewCell {
    
    @objc private func didSelectFilter() {
        
        // Check if tapped filter is selected before
        if isFilterCellSelected! {
            
            // Remove the filter cell from filter choices
            filteringPresenter.removeFilterCell(with: filterType, and: filterChoice)
            
        } else {
            
            // Append the filter cell to filter choices
            filteringPresenter.appendFilterCell(with: filterType, and: filterChoice)
            
        }
        
    }
    
}
