//
//  ContactListViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/4/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  
  @IBOutlet weak var contactsTableView: UITableView!
  let contactIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTableView()
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
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =  tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
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
    let addVC = self.storyboard?.instantiateViewController(withIdentifier: "addVC") as! ContactAddViewController
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
