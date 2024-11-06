//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Inderpreet Bhatti on 01/11/24.
//  Copyright © 2024 Inderpreet Bhatti. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        let titleText = K.appName
        var charIndex = 0.0;
        for char in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex , repeats: false) { _ in
                self.titleLabel.text?.append(String(char))
            }
            charIndex += 1;
        }
    }
    

}
