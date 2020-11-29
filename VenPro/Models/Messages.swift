//
//  Message.swift
//  VenPro
//
//  Created by Ricky Swasey on 9/19/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Messages: NSObject {
    var fromId: String?
    var text: String?
    var timeStamp: String?
    var toId: String?

    func chatPartnerId() -> String? {
    
        if fromId == Auth.auth().currentUser?.uid {
            return toId
        } else {
            return fromId
        }
    }
}
