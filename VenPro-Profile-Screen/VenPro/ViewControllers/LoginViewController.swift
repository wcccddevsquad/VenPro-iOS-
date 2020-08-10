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

    @IBOutlet weak var userTelephoneNumber: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignupButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "submitSegue", sender: self)
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        

        let phoneNumber = userTelephoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
          if let error = error {
//            self.showMessagePrompt(error.localizedDescription)
            print(error)
            return
          } else {
          // Sign in using the verificationID and the code sent to the user
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            print("Success!")
            }
        }

       self.performSegue(withIdentifier: "textVerify", sender: self)
}
    let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
}
