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
struct ThemeManager {
    static var color = Color()
    static var image = Image()
    static var fontName = FontName()
    static var fontSize = FontSize()
}

// MARK: - COLOR
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
    var datePickerBackground = UIColor(named: "Date Picker Background Color")
    var navigationBackground = UIColor(named: "Navigation Background Color")
    var searchBarBackground = UIColor(named: "Search Bar Background Color")
    var searchBarBorder = UIColor(named: "Search Bar Border Color")
    var searchBarBorderCorrect = UIColor(named: "Search Bar Border Correct Color")
    var searchBarBorderError = UIColor(named: "Search Bar Border Error Color")
    var subaccent = UIColor(named: "Subaccent Color")
    var subtitle = UIColor(named: "Subtitle Color")
    var title = UIColor(named: "Title Color")
}

// MARK: - IMAGE
/*
 Whenever you want to change the specific image, go to Images
 asset catalog which resides under Images folder under Resources folder
 and click the one you want to alter. After that, delete already existed
 images and drag and drop the one you wish to replace and you are done.
 */
struct Image {
    var buttonBildirimsizDevamEt = UIImage(named: "Button Bildirimsiz Devam Et")
    var buttonBugunuSec = UIImage(named: "Button Bugunu Sec")
    var buttonCikisYap = UIImage(named: "Button Cikis Yap")
    var buttonDuzenle = UIImage(named: "Button Duzenle")
    var buttonFiltrele = UIImage(named: "Button Filtrele")
    var buttonGirisYap = UIImage(named: "Button Giris Yap")
    var buttonRandevuOlustur = UIImage(named: "Button Randevu Olustur")
    var buttonRandevuyuIptalEt = UIImage(named: "Button Randevuyu Iptal Et")
    var buttonRandevuyuOnayla = UIImage(named: "Button Randevuyu Onayla")
    var buttonTarihiVeSaatiOnayla = UIImage(named: "Button Tarihi Ve Saati Onayla")
    var buttonVazgec = UIImage(named: "Button Vazgec")
    var logoAcDc = UIImage(named: "Logo AC DC")
    var logoAc = UIImage(named: "Logo AC")
    var logoAlert = UIImage(named: "Logo Alert")
    var logoDC = UIImage(named: "Logo DC")
    var logoHomepage = UIImage(named: "Logo Homepage")
    var logoLaunchScreen = UIImage(named: "Logo Launch Screen")
    var logoProfileButton = UIImage(named: "Logo Profile Button")
    var logoProfilePage = UIImage(named: "Logo Profile Page")
    var notificationDropDown = UIImage(named: "Notification Drop Down")
    var slider = UIImage(named: "Slider")
    var switchOff = UIImage(named: "Switch Off")
    var switchOn = UIImage(named: "Switch On")
}

// MARK: - FONT NAME
/*
 If you want to change the specific Font in FontName struct
 with Swift's built-in Fonts, then find the name of Font and
 replace it with the value assigned to variables under FontName
 struct.
 However, If you want to change it with custom Font, then add
 the specified Font to somewhere under this Resources folder
 with drag and drop. After that open a new row as
 "Fonts provided by application" in Information property list,
 add the name of Font to items section appeared after clicking
 drop down menu and you are good to go.
 */
struct FontName {
    var body = "System"
    var cellBody = "System"
    var cellSubtitle = "Title 2"
    var cellTitle = "Title 1"
    var navigationTitle = "Title 1"
    var subtitle = "Title 2"
    var title = "Title 1"
}

// MARK: - FONT SIZE
/*
 Whenever you want to change the size of any Font specified under
 FontSize struct, just assign the new value to the corresponding
 varibales and you are good to go.
 */
struct FontSize {
    var body = 18.0
    var cellBody = 16.0
    var cellSubtitle = 16.0
    var cellTitle = 22.0
    var navigationTitle = 22.0
    var subtitle = 16.0
    var title = 18.0
}
