//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Inderpreet Bhatti on 01/11/24.
//  Copyright © 2024 Inderpreet Bhatti. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messageBrain = MessageBrain()
    var authBrain = AuthBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authBrain.delegate = self
        messageBrain.delegate = self
        messageTextfield.delegate = self
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        messageBrain.loadMessages()
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        authBrain.logout()
    }
    
}

//MARK: - UITableViewDataSource


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageBrain.getMessagesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,  for: indexPath) as! MessageCell
        let message = messageBrain.getMessageByIndex(indexPath.row)
        cell.label?.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
    
    
    
}

//MARK: - UITextField

extension ChatViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextfield.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let messageBody = textField.text {
            messageBrain.addMessage(messageBody: messageBody)
        }
        messageTextfield.text = ""
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        messageTextfield.endEditing(true)
        if let messageBody = messageTextfield.text {
            messageBrain.addMessage(messageBody: messageBody)
        }
        messageTextfield.text = ""
    }

}


//MARK: - MessageBrainDelegate

extension ChatViewController : MessageBrainDelegate {
    
    func didLoadMessages(_ messageBrain: MessageBrain) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: messageBrain.getMessagesCount()-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func didGetError(_ error: any Error) {
        print(error);
    }
    
    
}

//MARK: - AuthBrainDelegate

extension ChatViewController : AuthBrainDelegate {
    func didLogout(_ authBrain: AuthBrain) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
