//
//  TextVerificationViewController.swift
//  VenPro
//
//  Created by Henry Feiler on 7/14/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class TextVerificationViewController: UIViewController {

    @IBOutlet weak var verifyCodeTextField: UITextField!
    
    @IBAction func SubmitVerificationButton(_ sender: Any) {
        
        let verificationCode = verifyCodeTextField.text!
        
        let defaults = UserDefaults.standard
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVerificationID")!, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (user, error)  in
        if error != nil {
            print("Error")
        } else {
            self.performSegue(withIdentifier: "profileSegue", sender: self)
            print("Successfully logged in")
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
