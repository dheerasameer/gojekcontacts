//
//  ValidationHelper.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/8/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import Foundation

class ValidationHelper {
  
  static func isValidUrl(urlString: String) -> Bool {
    let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
    let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
    let result = urlTest.evaluate(with: urlString)
    print(result)
    return result
  }
  
}
