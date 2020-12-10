//
//  DrinkOrderViewController.swift
//  VenPro
//
//  Created by India Doria on 11/2/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class DrinkOrderViewController: UIViewController {
    
    @IBAction func checkout(_ sender: Any) {
         performSegue(withIdentifier: "checkout", sender: UIButton.self)
    }
    
     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
     }
}
