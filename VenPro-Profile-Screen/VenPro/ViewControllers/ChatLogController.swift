//
//  ChatLogController.swift
//  VenPro
//
//  Created by Ricky Swasey on 9/1/20.
//  Copyright © 2020 VenPro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ChatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    let attendeeDetails = DetailedAttendeeViewController()
    
    var fromId: String?
    
    var toId: String?
    
    let cellId = "cellId"
    
//    var timeStamp: String?
    
    var user: User? {
        didSet {
            navigationItem.title = user?.firstName
        }
    }
    
    var messages = [Messages]()
    
    
    lazy var inputTextField: UITextField = {
        //programically creating text field
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupInputComponents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        observeMessages()
    }
    
    func setupInputComponents() {
        //programically setting up the text input area
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        //changes color of input box
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        
        //ios9 constraint anchors
        //x,y,w,h
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        
        containerView.addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        
        containerView.addSubview(inputTextField)
        //x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        let seperatorLineView = UIView()
        seperatorLineView.backgroundColor = .black
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(seperatorLineView)
        //x,y,w,h
        seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    @objc func handleSend() {
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
//        let toId = user?.id
//        print(toId)
        print("toID is \(String(describing: toId))")
        let timestamp = String(NSDate().timeIntervalSince1970)
        let fromID = Auth.auth().currentUser?.uid
        let values = ["text": inputTextField.text!, "toId": toId, "timeStamp": timestamp, "fromID": fromID]
        childRef.updateChildValues(values as [AnyHashable : Any])
        
        inputTextField.text = nil
        
        
        
//        print(inputTextField.text)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    
    func observeMessages() {
        guard (Auth.auth().currentUser?.uid) != nil else {
        return
        }
        //this works
        let userMessagesRef = Database.database().reference().child("messages")//.child(uid)
        //this works
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            //does work
//            print(snapshot)
            
            let messageId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                //this works
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                
                 //works
                let message = Messages()
                 //crashes
//                message.setValuesForKeys(dictionary)
                message.text = dictionary["text"] as? String
//                print("something else")
                print("message is \(String(describing: message.text))")
                self.messages.append(message)

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }, withCancel: nil)
            
   //         print("snapshot key = \(messageId)")
        }, withCancel: nil)
    }
        
//        let ref = Database.database().reference().child("messages")
//        ref.observe(.childAdded, with: { (snapshot) in
            
            
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let message = Message()
//                message.setValuesForKeys(dictionary)
//                print(message.text)
//            }
            
            
//            print (snapshot)
//
//        }, withCancel:  nil)
//    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]
        cell.textView.text = message.text
        
        if message.fromId != Auth.auth().currentUser?.uid {
            cell.bubbleView.backgroundColor = UIColor.lightGray
            cell.textView.textColor = UIColor.black
            
        } else {
            cell.bubbleView.backgroundColor = UIColor.blue
            cell.textView.textColor = UIColor.white
        }
        
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }

}
