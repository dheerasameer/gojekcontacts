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
  
  var list: [ContactModel]? = nil
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
    self.list = nil
  }
  
  func testFetchAllContacts() {
    var flag: Bool = false
    var bError: Error? = nil
    let expectation = XCTestExpectation(description: "Download all contacts")
    ContactsHelper.fetchAllContacts { (contactList, success, error) in
      flag = success
      bError = error
      self.list = contactList
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 10.0)
    XCTAssert(flag && self.list != nil && self.list!.count > 0, bError!.localizedDescription)
  }
  
  func testFetchContactDetails() {
    var flag: Bool = false
    var bError: Error? = nil
    let expectation = XCTestExpectation(description: "Download contact details")
    ContactsHelper.fetchContactDetails(self.contact!) { (success, error) in
      flag = success
      bError = error
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 10.0)
    XCTAssert(flag, bError!.localizedDescription)
  }
  
  func testUpdateContact() {
    var flag: Bool = false
    var bError: Error? = nil
    self.contact!.firstName = "TestUser"
    self.contact!.isFavourite = !self.contact!.isFavourite
    let expectation = XCTestExpectation(description: "Update contact")
    ContactsHelper.updateContact(self.contact!, onlyFavorite: false) { (success, error) in
      flag = success
      bError = error
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 10.0)
    XCTAssert(flag && bError == nil, bError!.localizedDescription)
  }
  
  func testAddContact() {
    var flag: Bool = false
    var bError: Error? = nil
    let expectation = XCTestExpectation(description: "Add contact")
    ContactsHelper.addContact(self.newContact!) { (success, error) in
      flag = success
      bError = error
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 10.0)
    XCTAssert(flag && bError == nil, bError!.localizedDescription)
  }
}
