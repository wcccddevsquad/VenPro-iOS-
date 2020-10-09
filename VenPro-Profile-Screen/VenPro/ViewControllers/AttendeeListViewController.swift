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
    
    var name = "name"
    
    var toId: String?
    
    var user: User?
    
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
        var user = self.users[indexPath.row]
        getUsersName(user: user)
        getUserId(user: user)
        showChatControllerForUser(user: user)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchUser()
        print(users.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Attendee List"
    }
    
    func fetchUser() {
        
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                let user = User()
                
//                user.setValuesForKeys(dictionary)
                user.id = snapshot.key
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
    
    func showChatControllerForUser(user: User) {
        let chatLogController = ChatLogController()
        let AttendeeDetailScreen = DetailedAttendeeViewController()
        AttendeeDetailScreen.user = user
        chatLogController.user = user
        performSegue(withIdentifier: "AttendeeDetail", sender: nil)
        navigationItem.title = user.firstName
    }
    
    
    func getUsersName(user: User) -> String? {
        let chatLogController = ChatLogController()
        let AttendeeDetailScreen = DetailedAttendeeViewController()
        chatLogController.user = user
        name = user.firstName ?? "CameUpNil"
        AttendeeDetailScreen.name = name
        return name
    }
    
    func getUserId(user: User) -> String? {
        let chatLogController = ChatLogController()
        let AttendeeDetailScreen = DetailedAttendeeViewController()
        chatLogController.user = user
        toId = user.id ?? "cameUpNil"
        AttendeeDetailScreen.toId = toId
        return toId
    }
    
    //check later if this actually does anyhting and if I can delete
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AttendeeDetail") {
            let AttendeeVC = segue.destination as! DetailedAttendeeViewController
            
            AttendeeVC.name = name
            AttendeeVC.toId = toId

        }
    }


}
