//
//  DrinkMenuViewController.swift
//  DrinkMenu
//
//  Created by Fariha Hussain on 8/31/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit

class DrinkMenuViewController: UIViewController {

    @IBAction func drinkDetails(_ sender: Any) {
        performSegue(withIdentifier: "details", sender: UIButton.self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
}

