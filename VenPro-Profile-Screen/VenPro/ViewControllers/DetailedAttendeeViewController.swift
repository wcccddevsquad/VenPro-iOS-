//
//  DetailedAttendeeViewController.swift
//  VenPro
//
//  Created by Henry Feiler on 7/15/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailedAttendeeViewController: UIViewController {
    
    let attendeeList = AttendeeListViewController()
    
    var name: String?
    
    var user: User? {
        didSet {
            navigationItem.title = user?.firstName
        }
    }
    
    
    @IBAction func messageButtonPressed(_ sender: Any) {
        showChatController()
        
    }
    
    
    @IBAction func DrinkMenuPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "DrinkMenuSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = name
        
        // Do any additional setup after loading the view.
    }
    
    var messagesController: AttendeeListViewController?
    
    func showChatController() {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.navigationItem.title = name
          navigationController?.pushViewController(chatLogController, animated: true)
          navigationItem.title = name
    }
    
}
