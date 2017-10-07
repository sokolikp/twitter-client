//
//  LoginViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/29/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.green.cgColor
    }

    
    @IBAction func onLogin(_ sender: Any) {
        TwitterClient.sharedInstance.login(success: { (user: User?) in
            if (user != nil) {
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            }
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }

}
