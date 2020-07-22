//
//  LoginViewController.swift
//  VenPro
//
//  Created by Henry Feiler on 7/14/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func SignupButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToAccountCreationScreen", sender: self)
    }
    
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "LoggedIn", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
