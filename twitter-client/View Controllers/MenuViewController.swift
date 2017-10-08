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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        let homeTimelineNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        let mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        
        viewControllers.append(["name": "Profile", "controller": profileNavigationController])
        viewControllers.append(["name": "Timeline", "controller": homeTimelineNavigationController])
        viewControllers.append(["name": "Mentions", "controller": mentionsNavigationController])
        
        hamburgerViewController.contentViewController = viewControllers[1]["controller"] as! UIViewController
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / CGFloat(viewControllers.count) - 1
    }

}
