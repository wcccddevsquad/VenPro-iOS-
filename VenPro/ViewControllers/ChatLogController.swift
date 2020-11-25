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
    
    var chatPairId: String?
    
    let cellId = "cellId"
    
    
    var user: User? {
        didSet {
            navigationItem.title = user?.firstName
            
            
        }
    }
    
    var messages = [Messages]()
    
    var messagesDictionary = [String: Messages]()
    
    
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
        
        observeMessages()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        print("pair id is \(chatPairId)")
        
        setupInputComponents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // observeMessages()
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
        
        let ref = Database.database().reference().child("messages").child("chat Pair Id's").child((chatPairId)!)
        let childRef = ref.childByAutoId()
        let timestamp = String(NSDate().timeIntervalSince1970)
        let fromID = Auth.auth().currentUser?.uid
        let values = ["text": inputTextField.text!, "toId": toId, "fromId": fromID, "timestamp": timestamp]
        childRef.updateChildValues(values)
        
        
        print(inputTextField.text)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    
    
    
    func observeMessages() {
        
        let userMessagesRef = //Database.database().reference().child("messages")
            
            Database.database().reference().child("messages").child("chat Pair Id's").child((chatPairId)!)
        
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            print("the snapshot is \(messageId)")
            
            
            let messagesRef = Database.database().reference().child("messages").child("chat Pair Id's").child((self.chatPairId)!).child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                            
                
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                let message = Messages()
                var chatCell = ChatMessageCell()
                
                message.text = dictionary["text"] as? String
                message.toId = dictionary["toId"] as? String
                message.fromId = dictionary["fromId"] as? String
                
                chatCell.messageId = message.fromId

                //this shows the messages in the chat
                self.messages.append(message)


                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]
        cell.textView.text = message.text
        
        cell.bubbleWidthAnchor?.constant = estimatedFrameForText(text: message.text!).width + 32
        
        if message.fromId == Auth.auth().currentUser?.uid {
            cell.bubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
            cell.textView.textColor = .white
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleViewRightAnchor?.isActive = true
            
        } else {
            cell.bubbleView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            cell.textView.textColor = .black
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleViewRightAnchor?.isActive = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
        var height: CGFloat = 80

        if let text = messages[indexpath.item].text {
            height = estimatedFrameForText(text: text).height + 20
        }
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
    }

}
