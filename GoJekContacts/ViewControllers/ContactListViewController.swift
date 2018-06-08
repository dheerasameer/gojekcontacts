//
//  ContactListViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/4/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private var contactsList: [ContactModel]? = nil {
    didSet {
      self.contactsTableView.reloadData()
    }
  }
  
  private let contactIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  
  @IBOutlet weak var contactsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTableView()
    ContactsHelper.fetchAllContacts { [weak self] (list, success, error) in
      if success {
        DispatchQueue.main.async {
          self?.contactsList = list
        }
      } else {
        print(error!.localizedDescription)
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let indexPath = self.contactsTableView.indexPathForSelectedRow {
      self.contactsTableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK:- UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var count = 0
    if let list = self.contactsList {
      count = list.count
    }
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let contact = self.contactsList![indexPath.row]
    let cell =  tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
    cell.contactNameLabel.text = contact.firstName! + " " + contact.lastName!
    cell.favouriteImageView.isHidden = !contact.isFavourite
    // TODO: Update contact image
    return cell
  }
  
  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return contactIndexTitles
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let contactDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "contactDetailVC") as! ContactDetailViewController
    self.navigationController?.pushViewController(contactDetailVC, animated: true)
  }
  
  
  // MARK:- Interface callbacks
  
  @IBAction func addButtonTap(_ sender: UIBarButtonItem) {
    let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! ContactEditViewController
    let addVC = editVC as! ContactAddViewController
    // TODO: Better fix for navigation bar on editVC
    let navigationVC = UINavigationController(rootViewController: addVC)
    self.present(navigationVC, animated: true, completion: nil)
  }
  
  // MARK:- Private
  
  func setupTableView() {
    self.contactsTableView.delegate = self
    self.contactsTableView.dataSource = self
    self.contactsTableView.rowHeight = 64.0
    self.contactsTableView.sectionIndexColor = UIColor.lightGray
  }
  

}
