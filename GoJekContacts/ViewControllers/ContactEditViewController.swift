//
//  ContactEditViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/5/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private let detailLabels = ["First Name", "Last Name", "mobile", "email"]
  
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
    cell.detailTypeLabel.text = self.detailLabels[indexPath.row]
    cell.detailValueTextField.text = "+91 7022030522"
    return cell
  }
  
  
  // MARK:- Interface callbacks
  
  @IBAction func cancelButtonTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func doneButtonTap(_ sender: UIBarButtonItem) {
    
  }
  
  // MARK:- Private
  
  private func configureView() {
    // UITableView
    self.contactDetailsTableView.delegate = self
    self.contactDetailsTableView.dataSource = self
  }

}
