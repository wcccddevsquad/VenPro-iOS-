//
//  LoginViewController.swift
//  VenPro
//
//  Created by Henry Feiler on 7/14/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI


class LoginViewController: UIViewController, AuthUIDelegate {

    
    @IBOutlet weak var userNumber: UITextField!
    
    @IBAction func SignupButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToAccountCreationScreen", sender: self)
    }
    
    




    @IBAction func LoginButtonPressed(_ sender: Any) {
        
       self.performSegue(withIdentifier: "LoggedIn", sender: self)
}
    
}
