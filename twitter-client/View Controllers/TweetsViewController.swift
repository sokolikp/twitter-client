//
//  TwetsViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/29/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        // fetch tweets
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: Error) in
            print("Error getting timeline")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            refreshControl.endRefreshing()
            self.tableView.reloadData()
        }) { (error: Error) in
            print("Error getting timeline")
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    
}
