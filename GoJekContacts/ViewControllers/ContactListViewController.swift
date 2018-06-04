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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.contactsTableView.delegate = self
    self.contactsTableView.dataSource = self
    self.contactsTableView.rowHeight = 64.0
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
  
  // MARK:- Private
  
  
  

}
