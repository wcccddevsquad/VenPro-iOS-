//
//  TextVerificationLoginViewController.swift
//  VenPro
//
//  Created by Ricky Swasey on 9/9/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class TextVerificationLoginViewController: UIViewController {

    @IBOutlet weak var verifyCodeTextField: UITextField!
    
    let db = Firestore.firestore()

    
    @IBAction func SubmitVerificationButton(_ sender: Any) {
        
        
        
//        let verificationCode = verifyCodeTextField.text!
      let verificationCode = "654321"
        
        
        let defaults = UserDefaults.standard
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVerificationID")!, verificationCode: verificationCode)
        
        var ref: DocumentReference? = nil

        
        Auth.auth().signIn(with: credential) { (user, error)  in
        if error != nil {
            print("Error")
        } else {
            self.performSegue(withIdentifier: "LoginToprofileSegue", sender: self)
            print("User successfully created")
//            db.collection("users").addDocument(data: ["firstname": "Bruce", "lastname": "Wayne"])
            // Add a new document with a generated ID
            // Add a second document with a generated ID.
            ref = self.db.collection("users").addDocument(data: [
                "first": "Alan",
                "middle": "Mathison",
                "last": "Turing",
                "born": 1912
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            }
            
        }
        
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }

}
