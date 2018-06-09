//
//  ErrorHelper.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/9/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import Foundation

enum ErrorType {
  case JsonSerialization
  case DataProcessing
  func getDescription() -> String {
    switch self {
    case .JsonSerialization:
      return "Error in JSON Serialization"
    case .DataProcessing:
      return "Error in Data"
    }
  }
}

class ErrorHelper {
  
  private static let errorDomain = "GO-JEK"
  
  static func getError(type errorType: ErrorType) -> Error {
    let error = NSError(domain: errorDomain, code: errorType.hashValue, userInfo: [NSLocalizedDescriptionKey: errorType.getDescription()])
    return error
  }
  
  static func getErrorForResponse(_ response: URLResponse) -> Error {
    let status = (response as! HTTPURLResponse).statusCode
    let error = NSError(domain: "GO-JEK", code: status, userInfo: [NSLocalizedDescriptionKey : HTTPURLResponse.localizedString(forStatusCode: status)])
    return error
  }
}
