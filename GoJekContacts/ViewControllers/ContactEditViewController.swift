//
//  ContactEditViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/5/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController {
  
  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var contactImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewDidLayoutSubviews() {
    cameraButton.center = CGPoint(x: self.contactImageView.center.x + self.contactImageView.bounds.width/(2*sqrt(2)),
                                  y: self.contactImageView.center.y + self.contactImageView.bounds.height/(2*sqrt(2)))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

}
