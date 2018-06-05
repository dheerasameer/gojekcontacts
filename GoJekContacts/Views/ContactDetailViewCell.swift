//
//  ContactDetailViewCell.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/5/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactDetailViewCell: UITableViewCell {
  
  @IBOutlet weak var detailTypeLabel: UILabel!
  @IBOutlet weak var detailValueLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.initCell()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func initCell() {
//    self.detailTypeLabel.text = "Mobile"
//    self.detailValueLabel.text = "+91 7022030522"
  }

}
