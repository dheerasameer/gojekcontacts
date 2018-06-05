//
//  ContactDetailViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/5/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactNameLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    self.updateWithDetails()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK:- Private
  
  private func configureView() {
    
    // ImageView
    self.contactImageView.layer.cornerRadius = self.contactImageView.bounds.width/2
    self.contactImageView.layer.masksToBounds = true
    self.contactImageView.layer.borderWidth = 3.0
    self.contactImageView.layer.borderColor = UIColor.white.cgColor
  }
  
  private func updateWithDetails() {
    self.contactImageView.image = UIImage(named: "sameer.jpg")
    self.contactNameLabel.text = "Sameer"
  }
  
}
