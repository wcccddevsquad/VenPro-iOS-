//
//  DetailedAttendeeViewController.swift
//  VenPro
//
//  Created by Henry Feiler on 7/15/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit

class DetailedAttendeeViewController: UIViewController {
    
    
    @IBAction func messageButtonPressed(_ sender: Any) {
        showChatController()
    }
    
    
    @IBAction func DrinkMenuPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "DrinkMenuSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var messagesController: AttendeeListViewController?
    
    func showChatController() {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        
        //programically calling a segue
        navigationController?.pushViewController(chatLogController, animated: true)
    }
}
