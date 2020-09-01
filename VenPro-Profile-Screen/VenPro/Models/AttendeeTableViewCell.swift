//
//  AttendeeTableCellTableViewCell.swift
//  VenPro
//
//  Created by Henry Feiler on 7/11/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit

class AttendeeTableViewCell: UITableViewCell {
    @IBOutlet weak var attendeeImageView: UIImageView!
    
    @IBOutlet weak var attendeeNameLabel: UILabel!
    
    func update(with attendee: User) {
        attendeeNameLabel.text = attendee.userName
    }
}
