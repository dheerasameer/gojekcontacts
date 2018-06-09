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
//    var success: Bool = false
//    var fetchError: Error? = nil
//    let url = URL(string: contactsBaseURL)
//    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//      if error == nil {
//        if let responseData = data {
//          let responseJson = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as! Array<NSDictionary>
//          if let contactsJsonList = responseJson {
//            success = true
//            contactList = ContactParseHelper().getParsedContactsList(contactsJsonList)
//          } else {
//            fetchError = ErrorHelper.getError(type: .JsonSerialization)
//          }
//        }
//      }
//      else {
//        fetchError = error
//      }
//      completion(contactList, success, fetchError)
//    }
//    task.resume()
    contactList = ContactParseHelper().getParsedContactsList(MockData.mockContactsList)
    completion(contactList, true, nil)
  }
  
  static func fetchContactDetails(_ contact: ContactModel, completion: @escaping (Bool, Error?) -> Void) {
//    var success: Bool = false
//    var fetchError: Error? = nil
//    let url = URL(string: contact.details!.url!)
//    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//      if error == nil {
//        if let responseData = data {
//          let responseJson = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as! NSDictionary
//          if let detailsJson = responseJson {
//            success = true
//            ContactParseHelper().parseAndUpdateContactDetails(withDetails: detailsJson, for: contact)
//          } else {
//            fetchError = ErrorHelper.getError(type: .JsonSerialization)
//          }
//        }
//      }
//      else {
//        fetchError = error
//      }
//      completion(success, fetchError)
//    }
//    task.resume()
    ContactParseHelper().parseAndUpdateContactDetails(withDetails: MockData.mockContactDetailsDictionary, for: contact)
    completion(true, nil)
  }
  
  static func updateContact(_ contact: ContactModel, onlyFavorite: Bool, completion: ((Bool, Error?) -> Void)?) {
    var contactDictionary: NSMutableDictionary! = nil
    if onlyFavorite {
      contactDictionary = ["favorite": contact.isFavourite]
    } else {
      contactDictionary = ContactParseHelper().getContactDictionary(contact)
    }
    let request = self.createRequest(method: "PUT", url: contact.details!.url!, data: contactDictionary)
    self.processRequest(request, completion: completion)
  }
  
  static func addContact(_ contact: ContactModel, completion: ((Bool, Error?) -> Void)?) {
    let contactDictionary = ContactParseHelper().getContactDictionary(contact)
    let request = self.createRequest(method: "POST", url: contactsBaseURL, data: contactDictionary)
    self.processRequest(request, completion: completion)
  }
  
  private static func createRequest(method: String, url: String, data: NSMutableDictionary) -> URLRequest {
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = method
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let json = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
    request.httpBody = json
    return request
  }
  
  private static func processRequest(_ request: URLRequest, completion: ((Bool, Error?) -> Void)?) {
    var success: Bool = false
    var processingError: Error? = nil
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if error == nil {
        if data != nil, response != nil {
          if ValidationHelper.isValidResponse(response!) {
            success = true
          } else {
            processingError = ErrorHelper.getErrorForResponse(response!)
          }
        } else {
          processingError = ErrorHelper.getError(type: .DataProcessing)
        }
      } else {
        processingError = error
      }
      if let completionBlock = completion {
        completionBlock(success, processingError)
      }
    }
    task.resume()
  }
  

}
