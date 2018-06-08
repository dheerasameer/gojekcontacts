//
//  ContactAddViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/7/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactAddViewController: ContactEditViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    super.contactDetailsTableView.dataSource = self
    super.contactDetailsTableView.delegate = self
    self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: Selector(("saveButtonTap:")))
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func saveButtonTap() {
    print("save clicked")
  }
  

}
