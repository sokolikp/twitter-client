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
    @IBOutlet weak var tweetView: UIView!
    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteRightMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var likeRightMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var replyLeftMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var replyRightMarginConstraint: NSLayoutConstraint!
    
    var tweet: Tweet!
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true

        reloadView()
    }

    // MARK: action outlet methods
    @IBAction func onCLickRetweet(_ sender: Any) {
        if (!tweet.retweeted) {
            TwitterClient.sharedInstance.retweet(id: tweet.id!, success: { (originalTweet: Tweet, retweet: Tweet) in
                self.tweet = originalTweet
                self.reloadView()
            }) { (error: Error) in
                print("Failure: \(error.localizedDescription)")
            }
        } else {
            TwitterClient.sharedInstance.unretweet(id: tweet.id!, success: { (tweet: Tweet) in
                self.tweet = tweet
                self.reloadView()
            }) { (error: Error) in
                print("Failure: \(error.localizedDescription)")
            }
        }
        
    }
    
    @IBAction func onClickLike(_ sender: Any) {
        
        if (!tweet.liked) {
            TwitterClient.sharedInstance.favorite(id: tweet.id!, success: { (tweet: Tweet) in
                self.tweet = tweet
                self.reloadView()
            }) { (error: Error) in
                print("Failure: \(error.localizedDescription)")
            }
        } else {
            TwitterClient.sharedInstance.unfavorite(id: tweet.id!, success: { (tweet: Tweet) in
                self.tweet = tweet
                self.reloadView()
            }) { (error: Error) in
                print("Failure: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func onClickDelete(_ sender: Any) {
        TwitterClient.sharedInstance.deleteTweet(id: tweet.id!, success: {
            self.navigationController?.popViewController(animated: true)
        }) { (error: Error) in
            print("Failure: \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReplyToTweetSegue" {
            let navigationController = segue.destination as! UINavigationController
            let composeViewController = navigationController.topViewController as! ComposeTweetViewController
            composeViewController.respondToTweet = tweet
        }
    }
    
    // MARK: helper functions
    // initialize outlet data
    func reloadView () {
        // set labels
        nameLabel.text = tweet.user?.name
        handleLabel.text = "@\(tweet.user?.handle ?? "")"
        tweetLabel.text = tweet.text
        locationLabel.text = tweet.place ?? ""
        retweetsCountLabel.text = String(tweet.retweetCount)
        likesCountLabel.text = String(tweet.favoritesCount)
        verifiedImageView.isHidden = !(tweet.user?.verified)!
        
        //set up action button alignment
        let frameWidth = view.frame.size.width
        var totalButtonWidth: CGFloat!
        var buttonCount: CGFloat!
        if tweet.user?.id != User.currentUser?.id {
            deleteButton.isHidden = true
            buttonCount = 3
            totalButtonWidth = replyButton.frame.size.width + retweetButton.frame.size.width + likeButton.frame.size.width
            
            let spaceBetweenButtons = (frameWidth - totalButtonWidth) / (buttonCount + 1)
            replyLeftMarginConstraint.constant = spaceBetweenButtons
            replyRightMarginConstraint.constant = spaceBetweenButtons
            likeRightMarginConstraint.isActive = false
            let newLikeRightMarginConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: likeButton, attribute: .trailing, multiplier: 1, constant: spaceBetweenButtons)
            
            newLikeRightMarginConstraint.isActive = true
        } else {
            buttonCount = 4
            totalButtonWidth = replyButton.frame.size.width + retweetButton.frame.size.width + likeButton.frame.size.width + deleteButton.frame.size.width
            
            let spaceBetweenButtons = (frameWidth - totalButtonWidth) / (buttonCount + 1)
            replyLeftMarginConstraint.constant = spaceBetweenButtons
            replyRightMarginConstraint.constant = spaceBetweenButtons
            likeRightMarginConstraint.constant = spaceBetweenButtons
            deleteRightMarginConstraint.constant = spaceBetweenButtons
        }
        
        // set images
        profileImageView.setImageWith((tweet.user?.profileUrl)!)
        setButtonImages()
        
        // set timestamp
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy, h:mm a"
        let timestampText = formatter.string(from: tweet.timestamp! as Date)
        timestampLabel.text = timestampText
    }
    
    func setButtonImages () {
        retweetButton.setImage(tweet.getRetweetImage(), for: UIControlState.normal)
        likeButton.setImage(tweet.getLikeImage(), for: UIControlState.normal)
    }

}
