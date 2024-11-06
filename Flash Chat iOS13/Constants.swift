//
//  File.swift
//  Flash Chat iOS13
//
//  Created by Inderpreet Bhatti on 01/11/24.
//  Copyright © 2024 Inderpreet Bhatti. All rights reserved.
//

struct K {
    static let appName = "⚡️Flash Chat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
