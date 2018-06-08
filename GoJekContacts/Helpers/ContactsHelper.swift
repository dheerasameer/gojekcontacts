//
//  ContactsHelper.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/8/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import Foundation

class ContactsHelper {
  
  static let contactsBaseURL = "http://gojek-contacts-app.herokuapp.com/contacts.json"
  
  static func fetchAllContacts(completion: @escaping ([ContactModel]?, Bool, Error?) -> Void) {
    var contactList: [ContactModel]? = nil
    var success: Bool = false
    let url = URL(string: contactsBaseURL)
    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
      if error == nil {
        var jsonError: NSError? = nil
        if let responseData = data {
          let responseJson = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as! Array<NSDictionary>
          if let contactsJsonList = responseJson {
            success = true
            contactList = ContactParseHelper().getParsedContactsList(contactsJsonList)
          } else {
            jsonError = NSError(domain: "GO-JEK", code: 0001, userInfo: [NSLocalizedDescriptionKey: "Error in JSON Serialization"])
          }
          completion(contactList, success, jsonError)
        }
      }
      else {
        completion(nil, false, error)
      }
    }
    task.resume()
  }
  
  static func fetchContactDetails(_ contact: ContactModel, completion: @escaping (Bool, Error?) -> Void) {
    var success: Bool = false
    let url = URL(string: contact.details!.url!)
    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
      if error == nil {
        var jsonError: NSError? = nil
        if let responseData = data {
          let responseJson = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as! NSDictionary
          if let detailsJson = responseJson {
            success = true
            ContactParseHelper().parseAndUpdateContactDetails(withDetails: detailsJson, for: contact)
          } else {
            jsonError = NSError(domain: "GO-JEK", code: 0002, userInfo: [NSLocalizedDescriptionKey: "Error in JSON Serialization"])
          }
          completion(success, jsonError)
        }
      }
      else {
        completion(false, error)
      }
    }
    task.resume()
  }
}
