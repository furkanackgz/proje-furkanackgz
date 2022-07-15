//
//  FilterType.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 14.07.2022.
//

import Foundation

// This data type represents the filters that
// will be presented on filter types table view
struct FilterType {
    
    // Type is the name of each section
    var type: String
    
    // Filters are the each cell represented on
    // each section
    var filters: [String]
    
}
