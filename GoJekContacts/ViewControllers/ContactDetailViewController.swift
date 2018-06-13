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
  
  private var detailsDictionary = [0: ["mobile": ""], 1: ["email": ""]] {
    didSet {
      self.contactDetailsTableView.reloadData()
    }
  }
  
  var contact: ContactModel? = nil
  
  @IBOutlet weak var contactImageView: UIImageView!
  @IBOutlet weak var contactNameLabel: UILabel!
  
  @IBOutlet weak var contactDetailsTableView: UITableView!
  @IBOutlet weak var contactFavouriteButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    ContactsHelper.fetchContactDetails(self.contact!) { [weak self] (success, error) in
      if success {
        DispatchQueue.main.async {
          self?.detailsDictionary[0]!["mobile"] = self?.contact?.details?.mobile
          self?.detailsDictionary[1]!["email"] = self?.contact?.details?.email
        }
      } else {
        let alertVC = UIAlertController(title: "Error in fetching details", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alertVC.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.cancel, handler: nil))
        DispatchQueue.main.async {
          self?.present(alertVC, animated: true, completion: nil)
        }
      }
    }
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
    let fieldDictionary = self.detailsDictionary[indexPath.row]! as NSDictionary
    let fieldName = fieldDictionary.allKeys[0] as? String
    cell.detailTypeLabel.text = fieldName
    cell.detailValueLabel.text = fieldDictionary[fieldName!] as? String
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
    editVC.reloadWithContact(self.contact!)
    // TODO: Better fix for navigation bar on editVC
    let navigationVC = UINavigationController(rootViewController: editVC)
    self.present(navigationVC, animated: true, completion: nil)
  }
  
  @IBAction func messageButtonTap(_ sender: UIButton) {
    if MFMessageComposeViewController.canSendText() {
      let messageVC = MFMessageComposeViewController()
      messageVC.recipients = [self.contact!.details!.mobile!]
      messageVC.messageComposeDelegate = self
      self.present(messageVC, animated: false, completion: nil)
    }
  }
  
  @IBAction func callButtonTap(_ sender: UIButton) {
    guard let number = URL(string: "tel://" + self.contact!.details!.mobile!) else { return }
    UIApplication.shared.open(number)
  }
  
  @IBAction func emailButtonTap(_ sender: UIButton) {
    if MFMailComposeViewController.canSendMail() {
      let emailVC = MFMailComposeViewController()
      emailVC.setToRecipients([self.contact!.details!.email!])
      self.present(emailVC, animated: false, completion: nil)
    }
  }
  
  @IBAction func favouriteButtonTap(_ sender: UIButton) {
    if self.contact!.isFavourite {
      self.contactFavouriteButton.setImage(UIImage(named: "icon_favourite"), for: .normal)
    } else {
      self.contactFavouriteButton.setImage(UIImage(named: "icon_favourite_selected"), for: .normal)
    }
    self.contact!.isFavourite = !self.contact!.isFavourite
    ContactsHelper.updateContact(contact!, onlyFavorite: true, completion: nil)
  }
  
  // MARK:- Public
  
  func reloadWithContact(_ contact: ContactModel) {
    self.contact = contact
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
    if let contactImage = self.contact?.profilePic {
      self.contactImageView.image = contactImage
    }
    self.contactNameLabel.text = self.contact!.firstName! + " " + self.contact!.lastName!
    if self.contact!.isFavourite {
      self.contactFavouriteButton.setImage(UIImage(named: "icon_favourite_selected"), for: .normal)
    }
  }
  
}
