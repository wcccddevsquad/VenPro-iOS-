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
import FirebaseAuth


class LoginViewController: UIViewController, AuthUIDelegate {

    
    @IBOutlet weak var userNumber: UITextField!
    
    lazy var phoneNumber = "+1\(String(describing: userNumber.text))"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignupButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToAccountCreationScreen", sender: self)
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
//   if let error = error {
//    self.showMessagePrompt(error.localizedDescription)
//        return
//   }
   // Sign in using the verificationID and the code sent to the user
   // ...
 }
        
       self.performSegue(withIdentifier: "LoggedIn", sender: self)
}
    
}
