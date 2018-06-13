//
//  ContactModel.swift
//  GoJekContacts
//
//  Created by K.Dheerasameer on 6/8/18.
//  Copyright © 2018 Go-Jek. All rights reserved.
//

// Json
//"id": 1484,
//"first_name": "123",
//"last_name": "2312312",
//"profile_pic": "/images/missing.png",
//"favorite": true,
//"url": "http://gojek-contacts-app.herokuapp.com/contacts/1484.json"

import UIKit

class ContactModel {
  var id: Int16?
  var firstName: String?
  var lastName: String?
  var profilePicUrl: String?
  var profilePic: UIImage?
  var isFavourite: Bool = false
  var details: DetailsModel?
  
  func updateProfilePic() {
//    let url = URL(string: "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/001/402/original/Screen_Shot_2018-03-29_at_11.43.36.png?1524763798")
//    var image: UIImage? = nil
//    let semaphore = DispatchSemaphore(value: 0)
//    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//      if error == nil {
//        if let responseData = data {
//          image = UIImage(data: responseData)
//        }
//      }
//      semaphore.signal()
//    }
//    task.resume()
//    _ = semaphore.wait(timeout: .distantFuture)
  }
}
