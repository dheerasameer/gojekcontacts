//
//  ContactTableViewCell.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/4/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactNameLabel: UILabel!
  @IBOutlet weak var favouriteImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.initCell()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func initCell() {
    self.contactImageView.image = UIImage(named: "sameer.jpg")
    self.contactNameLabel.text = "Sameer"
    self.contactImageView.layer.cornerRadius = 20.0
    self.contactImageView.layer.masksToBounds = true
  }

}
