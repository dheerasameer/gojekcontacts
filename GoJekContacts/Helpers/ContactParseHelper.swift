//
//  ContactParseHelper.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/8/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

//[
//  {
//    "id": 1484,
//    "first_name": "123",
//    "last_name": "2312312",
//    "profile_pic": "/images/missing.png",
//    "favorite": true,
//    "url": "http://gojek-contacts-app.herokuapp.com/contacts/1484.json"
//  }
//]

import Foundation

class ContactParseHelper {
  
  func getParsedContactsList(_ contactsList: [NSDictionary]) -> [ContactModel]? {
    var parsedContactsList = [ContactModel]()
    for item in contactsList {
      let contact = self.getParsedContact(from:item)
      parsedContactsList.append(contact)
    }
    return parsedContactsList
  }
  
  private func getParsedContact(from item: NSDictionary) -> ContactModel {
    let contact = ContactModel()
    contact.id = item["id"] as? Int16
    contact.firstName = item["first_name"] as? String
    contact.lastName = item["last_name"] as? String
    contact.profilePicUrl = item["profile_pic"] as? String
    contact.detailsURL = item["url"] as? String
    
    contact.updateProfilePic()
    return contact
  }
  
}
