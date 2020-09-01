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
import FirebaseAuth

class CreateAccountViewController: UIViewController, AuthUIDelegate {

    @IBOutlet weak var userTelephoneNumberTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    var ref: DatabaseReference!
    
    let user = Auth.auth().currentUser?.uid

    @IBAction func SubmitButtonPressed(_ sender: Any) {
        
        let phoneNumber = userTelephoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let firstName = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let useRname = userName.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
              if let error = error {
                print(error)
                return
              }
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                self.ref = Database.database().reference()
                self.ref.child("users").child(self.user!).setValue(["phoneNumber": phoneNumber,
                                                                   "firstName": firstName,
                                                                   "lastName": lastName,
                                                                   "email": email,
                                                                   "userName": useRname])
                self.performSegue(withIdentifier: "textVerifySegue", sender: self)
                print("Success!")
                
        }
        



        
            }
    
    let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
    
            override func viewDidLoad() {
                super.viewDidLoad()
                configureDatabase()
            }
    
    func configureDatabase() {
        
        ref = Database.database().reference()
    }
    
    @IBAction func clearButtonPushed(_ sender: Any) {
        
        userTelephoneNumberTextField.text?.removeAll()
        firstnameTextField.text?.removeAll()
        lastNameTextField.text?.removeAll()
        emailTextField.text?.removeAll()
        userName.text?.removeAll()
        
    }
    
    
}
