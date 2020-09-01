//
//  AttendeeListViewController.swift
//  VenPro
//
//  Created by Henry Feiler on 7/11/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class AttendeeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var ref: DatabaseReference!

    var users = [User]()
    
    fileprivate var _refHandle: DatabaseHandle!

    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        attendees.count
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attendee = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendeeCell", for: indexPath) as! AttendeeTableViewCell
        cell.update(with: attendee)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I was tapped!")
        performSegue(withIdentifier: "AttendeeDetail", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchUser()
        print(users.count)
    }
    
    func fetchUser() {
        
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                let user = User()
//                user.setValuesForKeys(dictionary)
                user.firstName = dictionary["firstName"] as? String
                user.lastName = dictionary["lastName"] as? String
                user.email = dictionary["email"] as? String
                user.userName = dictionary["userName"] as? String
                self.users.append(user)
                self.tableView.reloadData()
            }
            
            print(snapshot)
            
        }, withCancel: nil)
    
    }
    



}
