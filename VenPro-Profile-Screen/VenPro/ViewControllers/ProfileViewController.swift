//
//  ViewController.swift
//  VenPro
//
//  Created by Fariha Hussain on 7/8/20.
//  Copyright © 2020 VenPro. All rights reserved.
//
import SideMenu
import UIKit



class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var menu: SideMenuNavigationController?
    
    
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
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapMenu() {
    present(menu!, animated: true)
    }

}

class MenuListController: UITableViewController {
    //Controls the list of items in the menu
    
    var items = ["first", "Second"]
    
    let darkColor = UIColor(red: 33/255.0,
    green: 33/255.0,
    blue: 33/255.0,
    alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = darkColor
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
