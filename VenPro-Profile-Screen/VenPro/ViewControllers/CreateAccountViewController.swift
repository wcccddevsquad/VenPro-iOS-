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
    
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var email: String?
    var useRname: String?

    @IBAction func SubmitButtonPressed(_ sender: Any) {
        
         phoneNumber = userTelephoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         firstName = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         useRname = userName.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { (verificationID, error) in
              if let error = error {
                print(error)
                return
              }
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                self.ref = Database.database().reference()
                
        }
        
        print("first name is \(firstName) before throw")
//        let tvViewController = TextVerificationViewController()
//        let profileScreen = ProfileViewController()
//        tvViewController.firstName = firstName
//        tvViewController.lastName = lastName
//        tvViewController.email = email
//        tvViewController.userName = useRname
//        profileScreen.firstName = firstName
        
            performSegue(withIdentifier: "textVerifySegue", sender: self)
            print("Success!")

    
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "textVerifySegue") {
        let verificationVC = segue.destination as! TextVerificationViewController
        
        verificationVC.firstName = firstName
        verificationVC.lastName = lastName
        verificationVC.email = email
        verificationVC.userName = useRname
    }
    
    }
    
}
