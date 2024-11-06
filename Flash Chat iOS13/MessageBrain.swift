//
//  MessageBrain.swift
//  Flash Chat iOS13
//
//  Created by Inderpreet Bhatti on 03/11/24.
//  Copyright © 2024 Inderpreet Bhatti. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

protocol MessageBrainDelegate : AnyObject {
    func didLoadMessages(_ messageBrain: MessageBrain)
    func didGetError(_ error: Error)
}


class MessageBrain {
    var messages : [Message] = []
    let db = Firestore.firestore()
    weak var delegate : MessageBrainDelegate?
    
    func getMessagesCount() -> Int { return messages.count }
    
    func getMessageByIndex(_ index: Int) -> Message {
        return messages[index]
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            self.messages = []
            if let e = error {
                self.delegate?.didGetError(e)
            } else {
                if let queryDocuments = querySnapshot?.documents {
                    for doc in queryDocuments {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let text = data[K.FStore.bodyField] as? String {
                            let msg = Message(sender: sender, body: text)
                            self.messages.append(msg)
                            self.delegate?.didLoadMessages(self)
                        }
                    }
                }
            }
        }
    }
    
    func addMessage(messageBody: String) {
        if let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(
                data: [K.FStore.senderField: messageSender,
                       K.FStore.bodyField: messageBody,
                       K.FStore.dateField: Date().timeIntervalSince1970
                      ]) { error in
                if let e = error {
                    print("Error adding document: \(e.localizedDescription)")
                } else {
                    print("Document added with ID: \(self.db.collection(K.FStore.collectionName).document().documentID)")
                }
            }
        }
    }

    
    
}
