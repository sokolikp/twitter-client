//
//  ProfileViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 10/7/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var tweets: [Tweet]!
    var user: User!
    
    // MARK: lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // init tweet cell nib
        let cellNib = UINib(nibName: "TweetCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TweetCell")
        
        // default current user to logged in user
        if user == nil {
            user = User.currentUser
        }
        
        // set up top profile view
        initProfileView()
        
        // fetch personal tweets
        TwitterClient.sharedInstance.userTimeline(userId: (user?.id)!, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: Error) in
            print("Error! \(error.localizedDescription)")
        }
    }

    // MARK: delegate handlers
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailViewController
        detailsViewController.tweet = tweets[indexPath.row]
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    // MARK: helper functions
    func initProfileView () {
        self.title = user?.name
        if user?.backgroundUrl != nil {
            backgroundImageView.setImageWith(user.backgroundUrl!)
        }
        if user?.profileUrl != nil {
            profileImageView.setImageWith(user.profileUrl!)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 2
        
        userNameLabel.text = user.name
        userHandleLabel.text = "@\(user.handle ?? "")"
        tweetCountLabel.text = user.tweetCount!.formatPrettyString()
        followingCountLabel.text = user.followingCount!.formatPrettyString()
        followersCountLabel.text = user.followerCount!.formatPrettyString()
    }

}
