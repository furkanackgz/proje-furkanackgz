//
//  Filter.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 12.07.2022.
//

import Foundation

// Filter entity will be used in filtering page
// and it represents each filter choice of user.
struct Filter {
    var filterType: String?
    
    // Filter choice is types as Any because
    // filer choices can be both string and int.
    var filterChoice: Any?
}
