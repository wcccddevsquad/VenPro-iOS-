//
//  ViewController.swift
//  VenPro
//
//  Created by Fariha Hussain on 7/8/20.
//  Copyright © 2020 VenPro. All rights reserved.
//
import SideMenu
import UIKit
import FirebaseUI



class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MenuControllerDelegate {
    
    
    
    private let attendeeListController = AttendeeListViewController()
    private let eventInfoController = EventInfoViewController()
    private var menu: SideMenuNavigationController?
    
    var user = User()
    
    var account = CreateAccountViewController()
    
    
    var firstName: String?
    
    
    
    
    @IBOutlet weak var nickName: UITextField!
    
    @IBOutlet weak var aboutMeField: UITextView!
    
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBAction func uploadImage(_ sender: Any)
    {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileImage.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addUsernameInNavigation()
        let menuList = MenuListController(with: ["attendee list", "event info", "logout"])
        menuList.delegate = self
        
        print("users uid is \(account.user)")
        navigationItem.title = firstName
        
        menu = SideMenuNavigationController(rootViewController: menuList)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.leftSide = true
        menu?.delegate = self
        menu?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapMenu() {
    present(menu!, animated: true)
    }
    
    func didSelectMenuItem(named: String) {
        menu?.dismiss(animated: true, completion: { [weak self] in
            
            self?.title = named
            
            if named == "attendee list" {
                self?.performSegue(withIdentifier: "GoToAttendeeList", sender: self)
            } else if named == "event info"{
                self?.performSegue(withIdentifier: "GoToEventInfo", sender: self)
            } else if named == "logout" {
                    let firebaseAuth = Auth.auth()
//                do {
                    self?.handleLogout()
//                  try firebaseAuth.signOut()
//                } catch let signOutError as NSError {
//                  print ("Error signing out: %@", signOutError)
//                }
                    self?.performSegue(withIdentifier: "returnToLoginScreen", sender: self)
                
            }
        })
    }
    
    
    
    func addUsernameInNavigation() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(account.user!).observe(.value, with: { (snapshot) in
                //printed so this is working up to this point
                print(snapshot)
                
                if let dictionary = snapshot.value as? [String: Any] {
                    self.navigationItem.title = dictionary["userName"] as? String
                    //worked
                    print("this works")
                }
                
                
            }, withCancel: nil)

        }
    }
    
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    //viewWillLoad will only load once. this loads everytime and is to make sure the name updates
    override func viewWillAppear(_ animated: Bool) {
        CollectUsersDatabaseName()
    }
    
    func CollectUsersDatabaseName() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                print(snapshot)
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["firstName"] as? String
                }
                
            }, withCancel: nil)
        }
    }

}

