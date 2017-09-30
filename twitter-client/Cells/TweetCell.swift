//
//  TweetCell.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/30/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit
import NSDateMinimalTimeAgo

class TweetCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name
            handleLabel.text = tweet.user?.handle
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.timestamp?.timeAgo()
            
            if let profileUrl = tweet.user?.profileUrl {
                profileImageView.setImageWith(profileUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
