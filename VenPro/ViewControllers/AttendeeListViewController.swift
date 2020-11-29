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
    
    var messages = [Messages]()
    
    var chatPairId: String?
    
    
    //this code is a test
    var messageIdPair: Messages? {
        didSet {
            if let toId = message?.toId {
                let ref = Database.database().reference().child("users").child(toId)
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        
                    }
                }, withCancel: nil)
            }
        }
    }
    
    var message: Messages? {
        didSet {
            setUpChatPartnerId()
        }
    }
    
//    let message = messageIdPair[IndexPath.row]//////////////////this is the place to start back
    
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
        getUserPairId(user: user)
        showChatControllerForUser(user: user)
        
        guard let chatPartnerId = message?.chatPartnerId() else {
            print("did not work")
         //   print("the chat partner id is \(message?.chatPartnerId())")
            return
        }
        
        let ref = Database.database().reference().child("users").child("chatPartnerId")
        ref.observe(.value, with: { (snapshot) in
            print(snapshot)
        }, withCancel: nil)
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
    
    func getUserPairId(user: User) -> String? {
        let chatLogController = ChatLogController()
        let AttendeeDetailScreen = DetailedAttendeeViewController()
        //putting the uid values of the sender and the receiver in an array
        var pairIdArray = ["\(Auth.auth().currentUser?.uid)", "\(toId)"]
        print("pair Id Array = \(pairIdArray)")
        //putting the list in alphabetical order
        pairIdArray.sort()
        print("sorted pair Id Array = \(pairIdArray)")
        //join the array strings together as a regular string
        let joinedTest = pairIdArray.joined()
        print("the merged string should be \(joinedTest)")
        
        
        //chatPairId = "\(toId ?? "cameUpNil") \(Auth.auth().currentUser?.uid)"
        chatPairId = pairIdArray.joined()
        chatLogController.chatPairId = chatPairId
        AttendeeDetailScreen.chatPairId = chatPairId
        //chatPairIdWorksHere
        return chatPairId
    }
    
    
    func setUpChatPartnerId () {
        if let id = message?.chatPartnerId() {
            let ref = Database.database().reference().child("users").child(id)
            ref.observe(.value, with: { (snapshot) in
                
                //should there be code in here?
                
                
            }, withCancel: nil)
        }
    }
    
    
    //check later if this actually does anyhting and if I can delete
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AttendeeDetail") {
            let AttendeeVC = segue.destination as! DetailedAttendeeViewController
            
            AttendeeVC.name = name
            AttendeeVC.toId = toId
            AttendeeVC.chatPairId = chatPairId

        }
    }


}
