//
//  ContactEditViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/5/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private var detailsDictionary = [0: ["First Name": ""], 1: ["Last Name": ""], 2: ["mobile": ""], 3: ["email": ""]]
  private var contact: ContactModel? = nil
  
  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactDetailsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  override func viewDidLayoutSubviews() {
    cameraButton.center = CGPoint(x: self.contactImageView.center.x + self.contactImageView.bounds.width/(2*sqrt(2)),
                                  y: self.contactImageView.center.y + self.contactImageView.bounds.height/(2*sqrt(2)))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK:- UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =  tableView.dequeueReusableCell(withIdentifier: "contactDetailEditableCell", for: indexPath) as! ContactDetailEditableViewCell
    let fieldDictionary = self.detailsDictionary[indexPath.row]! as NSDictionary
    let fieldName = fieldDictionary.allKeys[0] as? String
    cell.detailTypeLabel.text = fieldName
    cell.detailValueTextField.text = fieldDictionary[fieldName!] as? String
    return cell
  }
  
  
  // MARK:- Interface callbacks
  
  @IBAction func cancelButtonTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func doneButtonTap(_ sender: UIBarButtonItem) {
    self.updateContactDetails()
    ContactsHelper.updateContact(self.contact!, onlyFavorite: false) { (success, error) in
      if success {
        print("details updated")
      }
    }
  }
  
  // MARK:- Public
  
  func reloadWithContact(_ contact: ContactModel) {
    self.contact = contact
    self.detailsDictionary[0]!["First Name"] = self.contact?.firstName
    self.detailsDictionary[1]!["Last Name"] = self.contact?.lastName
    self.detailsDictionary[2]!["mobile"] = self.contact?.details?.mobile
    self.detailsDictionary[3]!["email"] = self.contact?.details?.email
  }
  
  // MARK:- Private
  
  private func configureView() {
    // UITableView
    self.contactDetailsTableView.delegate = self
    self.contactDetailsTableView.dataSource = self
  }
  
  private func updateContactDetails() {
    self.contact?.firstName = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 0, section: 1))?.detailTextLabel?.text
    self.contact?.lastName = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 1, section: 1))?.detailTextLabel?.text
    self.contact?.details?.mobile = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 2, section: 1))?.detailTextLabel?.text
    self.contact?.details?.email = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 3, section: 1))?.detailTextLabel?.text
  }

}
