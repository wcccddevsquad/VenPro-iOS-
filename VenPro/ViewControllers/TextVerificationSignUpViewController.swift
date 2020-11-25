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

class TextVerificationSignUpViewController: UIViewController {

    @IBOutlet weak var verifyCodeTextField: UITextField!
    
    var ref: DatabaseReference!
    
    let db = Firestore.firestore()
    
    let accountInfo = CreateAccountViewController()
    
    var firstName: String?
    
    var lastName: String?
    
    var email: String?
    
    var phoneNumber: String?
    
    var userName: String?
    
    let user = User()

    
    @IBAction func SubmitVerificationButton(_ sender: Any) {
        
        
        
        let verificationCode = verifyCodeTextField.text!
//      let verificationCode = "654321"
        
        
        let defaults = UserDefaults.standard
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVerificationID")!, verificationCode: verificationCode)
        
        var ref: DocumentReference? = nil

        
        Auth.auth().signIn(with: credential) { (user, error)  in
        if error != nil {
            print("Error")
        } else {
            
            self.createUserInDatabase()
            
            //comes up nil
            print("name is currently \(self.firstName)")
            
//            self.performSegue(withIdentifier: "profileSegue", sender: self)
//            print("User successfully created")
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
        
        print("name is \(firstName) after throw")
    }
    
    func createUserInDatabase() {
    var uid = Auth.auth().currentUser?.uid
//
//        ref = Database.database().reference(fromURL: "https://venproios.firebaseio.com/")
//       let values = (["phoneNumber": phoneNumber, "firstName": firstName, "lastName": lastName, "email": email, "userName": userName])
//        ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
//            if err != nil {
//                print(err)
//                return
//            }
//
//
//        })
        
        ref = Database.database().reference()
        ref.child("users").child(uid!).setValue(["phoneNumber": phoneNumber, "firstName": firstName, "lastName": lastName, "email": email, "userName": userName])
    }
    

}
