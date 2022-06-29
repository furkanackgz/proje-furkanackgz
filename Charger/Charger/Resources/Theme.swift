//
//  Theme.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 29.06.2022.
//

import Foundation
import UIKit


/*
 Theme struct manages color, font name and font size of all
 UI elements in the project. It gives you the ability to
 manage them all in single place here.
 */
struct Theme {
    static var color = Color()
}

/*
 Whenever you want to change the specific color, go to Colors
 asset catalog which resides under Colors folder and click the
 one you want to alter. After that, click to rectangles named
 "Any Apperance" or "Dark" appering on the screen. And then click
 to the "Show Color Panel" on very buttom side of Attibutes Inspector
 and change the color as you wish.
 */
struct Color {
    var accent = UIColor(named: "Accent Color")
    var background = UIColor(named: "Background Color")
    var chosenCellBackground = UIColor(named: "Chosen Cell Background Color")
    var chosenCellBorder = UIColor(named: "Chosen Cell Border Color")
    var chosenCellTitle = UIColor(named: "Chosen Cell Title Color")
    var datePickerBackground = UIColor(named: "Date Picker Background Color")
    var navigationBackground = UIColor(named: "Navigation Background Color")
    var primaryButtonTint = UIColor(named: "Primary Button Tint Color")
    var primaryButtonTitle = UIColor(named: "Primary Button Title Color")
    var searchBarBackground = UIColor(named: "Search Bar Background Color")
    var searchBarBorder = UIColor(named: "Search Bar Border Color")
    var searchBarTitle = UIColor(named: "Search Bar Title Color")
    var secondaryButtonTint = UIColor(named: "Secondary Button Tint Color")
    var secondaryButtonTitle = UIColor(named: "Secondary Button Title Color")
    var subaccent = UIColor(named: "Subaccent Color")
    var subtitle = UIColor(named: "Subtitle Color")
    var tableViewInset = UIColor(named: "Table View Inset Color")
    var title = UIColor(named: "Title Color")
}
