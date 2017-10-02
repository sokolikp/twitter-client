//
//  LoginViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/29/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        TwitterClient.sharedInstance.login(success: { (user: User?) in
            if (user != nil) {
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }

}
