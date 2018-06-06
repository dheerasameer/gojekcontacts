//
//  ContactDetailEditableViewCell.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/6/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactDetailEditableViewCell: UITableViewCell {

  @IBOutlet weak var detailTypeLabel: UILabel!
  @IBOutlet weak var detailValueTextField: UITextField!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }

}
