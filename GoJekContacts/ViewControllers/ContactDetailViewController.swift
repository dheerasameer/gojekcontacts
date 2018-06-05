//
//  ContactDetailViewController.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/5/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {

  private let detailLabels = ["mobile", "email"]
  
  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactNameLabel: UILabel!
  
  @IBOutlet weak var contactDetailsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    self.updateWithDetails()
  }
  
  override func viewDidLayoutSubviews() {
    self.contactImageView.layer.cornerRadius = self.contactImageView.bounds.width/2
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
  
  
  // MARK:- MFMessageComposeViewControllerDelegate
  
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    switch (result.rawValue) {
    case MessageComposeResult.cancelled.rawValue:
      print("Message was cancelled")
      self.dismiss(animated: true, completion: nil)
    case MessageComposeResult.failed.rawValue:
      print("Message failed")
      self.dismiss(animated: true, completion: nil)
    case MessageComposeResult.sent.rawValue:
      print("Message was sent")
      self.dismiss(animated: true, completion: nil)
    default:
      break;
    }
  }
  
  
  // MARK:- Interface callbacks
  
  @IBAction func editButtonTap(_ sender: UIBarButtonItem) {
    let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as! ContactEditViewController
    self.present(editVC, animated: true, completion: nil)
  }
  
  @IBAction func messageButtonTap(_ sender: UIButton) {
    if MFMessageComposeViewController.canSendText() {
      let messageVC = MFMessageComposeViewController()
      messageVC.recipients = ["Enter tel-nr"]
      messageVC.messageComposeDelegate = self
      self.present(messageVC, animated: false, completion: nil)
    }
  }
  
  @IBAction func callButtonTap(_ sender: UIButton) {
    guard let number = URL(string: "tel://" + "123456") else { return }
    UIApplication.shared.open(number)
  }
  
  @IBAction func emailButtonTap(_ sender: UIButton) {
    if MFMailComposeViewController.canSendMail() {
      let emailVC = MFMailComposeViewController()
      emailVC.setToRecipients(["k.dheerasameer@gmail.com"])
      self.present(emailVC, animated: false, completion: nil)
    }
  }
  
  @IBAction func favouriteButtonTap(_ sender: UIButton) {
    //TODO: Put condition to show favourite and vice versa
  }
  
  // MARK:- Private
  
  private func configureView() {
    // UIImageView
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
