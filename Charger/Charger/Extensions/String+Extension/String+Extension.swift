//
//  String+Extension.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 4.07.2022.
//

import Foundation

extension String {
    
    /**
     IsValidEmailAddress method validates email address in a
     simple manner but it can be improved by enhancing the
     regular expression used. However, it works for 99% of
     all regular email address formats. So we will be fine.
     It simply creates a NSRegularExpression from a string
     which contains regular expression in it and compares this
     regular expression with the given emailAddress to the method.
     
     -parameter emailAddressString: It is the string containing
     email address inside.
     
     -returns: Bool depending on the matching of email address with
     regex.
     
    */
    func isValidEmail() -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
}

