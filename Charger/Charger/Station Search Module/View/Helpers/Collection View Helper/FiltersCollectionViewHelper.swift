//
//  FiltersCollectionViewHelper.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 13.07.2022.
//

import UIKit

class FiltersCollectionViewHelper: NSObject {
    
    // MARK: - Properties
    private var filterChoices = [Filter]()
    
    private weak var filtersCollectionView: UICollectionView?
    
    private var stationSearchPresenter: StationSearchContract.stationSearchPresenter!
    
    // MARK: - init
    init(_ filtersCollectionView: UICollectionView,
         _ stationSearchPresenter: StationSearchContract.stationSearchPresenter) {
        super.init()
        
        // Assign parameters came from view
        self.filtersCollectionView = filtersCollectionView
        self.stationSearchPresenter = stationSearchPresenter
        
        // Assign self as delegate and data source of collection view
        self.filtersCollectionView?.delegate = self
        self.filtersCollectionView?.dataSource = self
        
        // Assign compositional layout as collection view layout
        self.filtersCollectionView?.collectionViewLayout = createCompositionalLayout()
        
        // Register collection view cell to the collection view
        registerCell()
        
    }
    
}

// Self related methods
extension FiltersCollectionViewHelper {
    
    // MARK: - registerCell
    private func registerCell() {
        
        // Register filter cell to the collection view
        filtersCollectionView?.register(.init(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        
    }
    
    // MARK: - setFilterChoices
    func set(filterChoices: [Filter]) {
        self.filterChoices = filterChoices
        
        // Animate reloding collection view for better
        // user experience
        UIView.animate(withDuration: 0.375, delay: 0.5) { [weak self] in
            self?.filtersCollectionView?.reloadData()
        }
        
    }
    
}

// MARK: - Collection View Delegate
extension FiltersCollectionViewHelper: UICollectionViewDelegate {

}

// MARK: - Collection View Data Source
extension FiltersCollectionViewHelper: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterChoices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue filter cell and initialize its ui components
        let filterCell = dequequeFilterCell(collectionView, indexPath)
        
        // Return dequeued and initialized filter cell
        return filterCell
    }
    
}

// Dequeue station cell
extension FiltersCollectionViewHelper {
    
    // MARK: dequequeFilterCell
    private func dequequeFilterCell(_ collectionView: UICollectionView,
                                    _ indexPath: IndexPath) -> FilterCell {
        
        var filterCellResult: FilterCell?
        
        if let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell {
            
            // Set station search presenter
            filterCell.stationSearchPresenter = stationSearchPresenter
            
            // Set filter choice property
            filterCell.filterChoice = filterChoices[indexPath.row]
            
            // Cast any typed filter choice value to string
            if let filterChoice = filterChoices[indexPath.row].filterChoice as? String {
                
                // Set filter choice string value to the label text
                filterCell.filterChoiceLabel.text = filterChoice
                
            }
            
            filterCellResult = filterCell
        }
        
        // To prevent application crashing add the default initializer
        return filterCellResult ?? FilterCell()
    }
    
}

// Collection view layout related
extension FiltersCollectionViewHelper {
    
    // MARK: - createCompositionalLayout
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        // Set compositional layout properties
        let fraction: CGFloat = 1 / 3
        let inset: CGFloat = 10
        
        // Create items of groups
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset,
                                                     bottom: inset, trailing: inset)
        
        // Create groups of sections
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset,
                                                      bottom: inset, trailing: inset)
        
        // Create section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset,
                                                        bottom: inset, trailing: inset)
        
        // Set section as horizontally scrollable
        section.orthogonalScrollingBehavior = .continuous
        
        // Create compositional layout with created section and return it
        return UICollectionViewCompositionalLayout(section: section)
        
    }

    
}
