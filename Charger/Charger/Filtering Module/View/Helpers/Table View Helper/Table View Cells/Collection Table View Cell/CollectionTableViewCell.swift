//
//  CollectionTableViewCell.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 14.07.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tableCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var filterType: FilterType?
    
    var filteringPresenter: FilteringContract.filteringPresenter! {
        didSet {
            // After filtering presenter assigned,
            // awake collection view cell
            awakeCollectionTableViewCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// Self related methods
extension CollectionTableViewCell {
    
    // MARK: - awakeCollectionTableViewCell
    private func awakeCollectionTableViewCell() {
        
        // Set up ui components
        setupUI()
        
    }
    
    // MARK: - setupUI
    private func setupUI() {
        
        // Set background views
        setBackgroundViews()
        
        // Assign self as delegate and data source
        // for collection view
        tableCollectionView.delegate = self
        tableCollectionView.dataSource = self
        
        // Register cell
        registerCell()
        
    }
    
    // MARK: - setBackgroundViews
    private func setBackgroundViews() {
        // Set content view
        contentView.backgroundColor = ThemeManager.color.background
        
        // Set container view's background color
        containerView.backgroundColor = ThemeManager.color.background
        
        // Set table view's backgorund color
        tableCollectionView.backgroundColor = ThemeManager.color.background
    }
    
    // MARK: - registerCell
    private func registerCell() {
        
        // Register table collection view cell to th collection view
        tableCollectionView.register(.init(nibName: "TableCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "TableCollectionViewCell")
        
    }
    
    // MARK: - setFilterType
    func set(_ filterType: FilterType) {
        self.filterType = filterType
        
        // Animate reloding collection view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.tableCollectionView?.reloadData()
        }
    }
    
}

// MARK: - Collection View Delegate
extension CollectionTableViewCell: UICollectionViewDelegate {
    
}

// MARK: - Collection View Data Source
extension CollectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Unwrap filter type
        guard let filterType = filterType else { return 0}
        
        // Return number of filters in filter type
        return filterType.filters.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue table collection view cell
        let tableCollectionViewCell = dequeueTableCollectionViewCell(collectionView,
                                                                     indexPath)
        
        return tableCollectionViewCell
        
    }
    
}

// MARK: - Dequeue Table Collection View Cell
extension CollectionTableViewCell {
    
    private func dequeueTableCollectionViewCell(_ collectionView: UICollectionView,
                                                _ indexPath: IndexPath) -> TableCollectionViewCell {
        
        var tableCollectionViewCell: TableCollectionViewCell?
        
        if let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableCollectionViewCell", for: indexPath) as? TableCollectionViewCell {
            
            // Unwrap filter type
            if let filterType = filterType {
                
                // Get type of filter
                let type = filterType.type
                
                // Get choice of filter
                let choice = filterType.filters[indexPath.item]
                
                // Assign type of filter to the collection view cell
                collectionViewCell.filterType = type
                
                // Assign choice of filter to the collection view cell
                collectionViewCell.filterChoice = choice
                
                // Assign presenter to the collection view cell
                collectionViewCell.filteringPresenter = filteringPresenter
                
            }
            
            tableCollectionViewCell = collectionViewCell
        }
        
        return tableCollectionViewCell ?? TableCollectionViewCell()
    }
    
}
