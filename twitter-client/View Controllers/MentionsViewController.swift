//
//  MentionsViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 10/7/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let cellNib = UINib(nibName: "TweetCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TweetCell")
        
        // fetch mentions tweets
        TwitterClient.sharedInstance.mentions(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: Error) in
            print("Error! \(error.localizedDescription)")
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "DetailsSegue", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            let profileViewController = segue.destination as! ProfileViewController
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPath(for: cell)
            profileViewController.user = tweets[indexPath!.row].user
        } else if segue.identifier == "DetailsSegue" {
            let detailsViewController = segue.destination as! DetailViewController
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPath(for: cell)
            detailsViewController.tweet = tweets[indexPath!.row]
        }
    }
    
    func tweetCellDidTapProfileImage(tweetCell: TweetCell) {
        performSegue(withIdentifier: "ProfileSegue", sender: tweetCell)
    }

}
