//
//  ContactsHelperTests.swift
//  GoJekContactsTests
//
//  Created by K.Dheerasameer on 6/13/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import XCTest
@testable import GoJekContacts

class ContactsHelperTests: XCTestCase {
  
  var contact: ContactModel? = nil
  var newContact: ContactModel? = nil
  
  override func setUp() {
    super.setUp()
    contact = ContactModel()
    contact!.id = 1484
    contact!.details = DetailsModel()
    contact!.details!.url = "http://gojek-contacts-app.herokuapp.com/contacts/\(String(describing: contact!.id)).json"
    
    newContact = ContactModel()
    newContact!.firstName = "NewTest"
    newContact!.lastName = "User"
  }
  
  override func tearDown() {
    super.tearDown()
    self.contact?.details = nil
    self.contact = nil
    self.newContact = nil
  }
  
  func testFetchAllContacts() {
    ContactsHelper.fetchAllContacts { (contactList, success, error) in
      XCTAssert(success && contactList != nil && contactList!.count > 0, error!.localizedDescription)
    }
  }
  
  func testFetchContactDetails() {
    ContactsHelper.fetchContactDetails(self.contact!) { (success, error) in
      XCTAssert(success && self.contact!.details!.mobile != nil && self.contact!.details!.email != nil, error!.localizedDescription)
    }
  }
  
  func testUpdateContact() {
    self.contact!.firstName = "TestUser"
    self.contact!.isFavourite = !self.contact!.isFavourite
    ContactsHelper.updateContact(self.contact!, onlyFavorite: false) { (success, error) in
      XCTAssert(success && error == nil, error!.localizedDescription)
    }
    ContactsHelper.updateContact(self.contact!, onlyFavorite: true) { (success, error) in
      XCTAssert(success && error == nil, error!.localizedDescription)
    }
  }
  
  func testAddContact() {
    ContactsHelper.addContact(self.newContact!) { (success, error) in
      XCTAssert(success && error == nil, error!.localizedDescription)
    }
  }
}
