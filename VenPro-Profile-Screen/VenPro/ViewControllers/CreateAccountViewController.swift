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

    
    @IBAction func SubmitButtonPressed(_ sender: Any) {
        
                    let authUI = FUIAuth.defaultAuthUI()
                
                    authUI!.delegate = self as? FUIAuthDelegate
                
                    let phoneProvider = FUIPhoneAuth(authUI: authUI!)
                
                    authUI!.providers = [phoneProvider]
                
                    authUI!.signIn(withProviderUI: phoneProvider, presenting: self, defaultValue: nil)
                
                func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
                    if error != nil {
                  self.performSegue(withIdentifier: "LoggedIn", sender: self)
                    }
                }
                    
                
        //        let authUI = FUIAuth.defaultAuthUI()
        //        authUI?.delegate = self as? FUIAuthDelegate
        //
        //        let providers: [FUIAuthProvider] = [
        //            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!)]
        //
        //        authUI?.providers = providers
        //
        //        let authViewController = authUI?.authViewController()
        //
        //        self.present(authViewController!, animated: true) { }
        //
        //        func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        //          self.performSegue(withIdentifier: "LoggedIn", sender: self)
        //        }



        //        self.performSegue(withIdentifier: "LoggedIn", sender: self)
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
            }
}
