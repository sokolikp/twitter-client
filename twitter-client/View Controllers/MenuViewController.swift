//
//  MenuViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 10/5/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var viewControllers: [[String: Any]] = []
    var hamburgerViewController: HamburgerViewController!
    let menuItems = [
        ["name": "Profile", "identifier": "ProfileNavigationController"],
        ["name": "Timeline", "identifier": "TweetsNavigationController", "isDefault": true],
        ["name": "Mentions", "identifier": "MentionsNavigationController"]
    ]
    
    // MARK: lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // instantiate VCs in menuView
        for item in menuItems {
            addMenuItem(name: item["name"] as! String, controllerIdentifier: item["identifier"] as! String, setAsDefault: item["isDefault"] as? Bool ?? false)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
    }
    
    // MARK: delegate handlers
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]["controller"] as! UIViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.menuTitleLabel.text = viewControllers[indexPath.row]["name"] as? String
        
        return cell
    }
    
    // set row heights to take up entire screen height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / CGFloat(viewControllers.count) - 1
    }
    
    // MARK: helper functions
    func addMenuItem(name: String, controllerIdentifier: String, setAsDefault: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: controllerIdentifier)
        viewControllers.append(["name": name, "controller": controller])
        
        if setAsDefault {
            hamburgerViewController.contentViewController = controller
        }
    }
}
