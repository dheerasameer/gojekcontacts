//
//  ContactModel.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/8/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

// Json
//"id": 1484,
//"first_name": "123",
//"last_name": "2312312",
//"profile_pic": "/images/missing.png",
//"favorite": true,
//"url": "http://gojek-contacts-app.herokuapp.com/contacts/1484.json"

import Foundation

class ContactModel {
  var id: String?
  var firstName: String?
  var lastName: String?
  var profilePic: String?
  var isFavourite: Bool = false
  var detailsURL: String?
}
