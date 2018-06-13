//
//  ContactAddViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/7/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  private var detailsDictionary = [0: ["First Name": ""], 1: ["Last Name": ""], 2: ["mobile": ""], 3: ["email": ""]]
  private var contact = ContactModel()
  
  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactDetailsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidLayoutSubviews() {
    cameraButton.center = CGPoint(x: self.contactImageView.center.x + self.contactImageView.bounds.width/(2*sqrt(2)),
                                  y: self.contactImageView.center.y + self.contactImageView.bounds.height/(2*sqrt(2)))
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
  
  @IBAction func saveButtonTap(_ sender: UIBarButtonItem) {
    self.updateContactDetails()
    let alertVC = UIAlertController(title: "Add User", message: nil, preferredStyle: UIAlertControllerStyle.alert)
    
    ContactsHelper.addContact(self.contact) { (success, error) in
      if success {
        alertVC.message = "Added successfully"
        alertVC.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { [weak self] (action) in
          self!.dismiss(animated: true, completion: {
          })
        }))
      } else {
        alertVC.message = error?.localizedDescription
        alertVC.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.cancel, handler: { (action) in
          alertVC.dismiss(animated: true, completion: nil)
        }))
      }
      DispatchQueue.main.async {
        self.present(alertVC, animated: true, completion: nil)
      }
    }
  }
  
  // MARK:- Private
  
  private func configureView() {
    // UITableView
    self.contactDetailsTableView.delegate = self
    self.contactDetailsTableView.dataSource = self
  }
  
  private func updateContactDetails() {
    let firstNameCell = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ContactDetailEditableViewCell
    self.contact.firstName = firstNameCell.detailValueTextField.text!
    
    let lastNameCell = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ContactDetailEditableViewCell
    self.contact.lastName = lastNameCell.detailValueTextField.text!
    
    self.contact.details = DetailsModel()
    let mobileCell = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! ContactDetailEditableViewCell
    self.contact.details!.mobile = mobileCell.detailValueTextField.text!
    
    let emailCell = self.contactDetailsTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! ContactDetailEditableViewCell
    self.contact.details!.email = emailCell.detailValueTextField.text!
    
  }

}
