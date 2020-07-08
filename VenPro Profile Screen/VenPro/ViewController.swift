//
//  ViewController.swift
//  VenPro
//
//  Created by Fariha Hussain on 7/8/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

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
        // Do any additional setup after loading the view.
    }


}

