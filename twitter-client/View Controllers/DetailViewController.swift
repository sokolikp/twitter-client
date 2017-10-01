//
//  DetailViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/30/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true

        reloadTweetData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickReply(_ sender: Any) {
        // modally display tweet input
    }
    
    @IBAction func onCLickRetweet(_ sender: Any) {
        TwitterClient.sharedInstance.retweet(id: tweet.id!, success: { (tweet: Tweet) in
            print("success!")
            // todo: segue? Change icon color, update labels
        }) { (error: Error) in
            print("Failure: \(error.localizedDescription)")
        }
    }
    
    @IBAction func onClickLike(_ sender: Any) {
        TwitterClient.sharedInstance.favorite(id: tweet.id!, success: {
            print("liked")
            //TODO: changed icon color, update labels
        }) { (error: Error) in
            print("Failure: \(error.localizedDescription)")
        }
    }
    
    // initialize outlet data
    func reloadTweetData () {
        nameLabel.text = tweet.user?.name
        handleLabel.text = "@\(tweet.user?.handle ?? "")"
        tweetLabel.text = tweet.text
        profileImageView.setImageWith((tweet.user?.profileUrl)!)
        
        locationLabel.text = tweet.place ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy, h:mm a"
        let timestampText = formatter.string(from: tweet.timestamp! as Date)
        timestampLabel.text = timestampText
        retweetsCountLabel.text = String(tweet.retweetCount)
        likesCountLabel.text = String(tweet.favoritesCount)
    }

}
