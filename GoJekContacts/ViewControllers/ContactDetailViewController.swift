//
//  ContactDetailViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/5/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  private let detailLabels = ["mobile", "email"]
  
  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactNameLabel: UILabel!
  
  @IBOutlet weak var contactDetailsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    self.updateWithDetails()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK:- UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =  tableView.dequeueReusableCell(withIdentifier: "contactDetailCell", for: indexPath) as! ContactDetailViewCell
    cell.detailTypeLabel.text = self.detailLabels[indexPath.row]
    cell.detailValueLabel.text = "+91 7022030522"
    return cell
  }
  
  
  // MARK:- Private
  
  private func configureView() {
    
    // UIImageView
    self.contactImageView.layer.cornerRadius = self.contactImageView.bounds.width/2
    self.contactImageView.layer.masksToBounds = true
    self.contactImageView.layer.borderWidth = 3.0
    self.contactImageView.layer.borderColor = UIColor.white.cgColor
    
    // UITableView
    self.contactDetailsTableView.delegate = self
    self.contactDetailsTableView.dataSource = self
  }
  
  private func updateWithDetails() {
    self.contactImageView.image = UIImage(named: "sameer.jpg")
    self.contactNameLabel.text = "Sameer"
  }
  
}
