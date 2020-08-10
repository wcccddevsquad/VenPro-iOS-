//
//  CreateAccountViewController.swift
//  VenPro
//
//  Created by Henry Feiler on 7/14/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class CreateAccountViewController: UIViewController, AuthUIDelegate {

    @IBOutlet weak var userTelephoneNumber: UITextField!
    
    @IBAction func SubmitButtonPressed(_ sender: Any) {
                  let phoneNumber = userTelephoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
              if let error = error {
                print(error)
                return
              } else {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                self.performSegue(withIdentifier: "textVerifySegue", sender: self)
                print("Success!")

                }

            }

        }
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
    
            override func viewDidLoad() {
                super.viewDidLoad()
            }
}
