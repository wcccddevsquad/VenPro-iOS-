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
    
    lazy var profileImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.image = UIImage(named:"profileDefaultImage")
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.contentMode = .scaleAspectFit
       
           imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
           imageView.isUserInteractionEnabled = true
           
       return imageView
       }()

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
        
        
        //testing image code below
              
              
              let storageRef = Storage.storage().reference().child("myImage.png")
              
              if let uploadData = self.profileImageView.image!.pngData() {
                  
                     storageRef.putData(uploadData, metadata: nil, completion:
                      { (metadata, error) in
                          
                          if error != nil {
                            print(error as Any)
                              return
                          }
                          
                        print(metadata as Any)
                          
                     })
                  
              }
              
           
              
              
         //Below is original code before new profile image codes

        
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
        
            performSegue(withIdentifier: "textVerifySegue", sender: self)
            print("Success!")

    
        
            }
    
    let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
    
            override func viewDidLoad() {
                super.viewDidLoad()
                view.addSubview(profileImageView)
                
                setupProfileImageView()
                idCheck()
                configureDatabase()
                
                
            }
    
    // func setupProfileImageView is new code added
    
    func setupProfileImageView() {
       profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

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
        let verificationVC = segue.destination as! TextVerificationSignUpViewController
        
        verificationVC.firstName = firstName
        verificationVC.lastName = lastName
        verificationVC.email = email
        verificationVC.userName = useRname
    }
    
    }
    
    func idCheck() {
        if Auth.auth().currentUser?.uid != nil {
            print("uid already exist")
        }
    }
    
}
