//
//  ViewController.swift
//  VenPro
//
//  Created by Fariha Hussain on 7/8/20.
//  Copyright © 2020 VenPro. All rights reserved.
//
import SideMenu
import UIKit



class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MenuControllerDelegate {
    
    
    
    private let attendeeListController = AttendeeListViewController()
    private let eventInfoController = EventInfoViewController()
    private var menu: SideMenuNavigationController?
    
    
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
        
        let menuList = MenuListController(with: ["attendee list", "event info", "logout"])
        
        menuList.delegate = self
        
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
                
            }
        })
    }

}

