//
//  TweetCell.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/30/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit
import NSDateMinimalTimeAgo

@objc protocol TweetCellDelegate {
    @objc optional func tweetCellDidTapProfileImage(tweetCell: TweetCell)
}

class TweetCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var verifiedImageView: UIImageView!
    
    weak var delegate: TweetCellDelegate?
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name
            handleLabel.text = "@\(tweet.user?.handle ?? "")"
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.timestamp?.timeAgo()
            
            verifiedImageView.isHidden = !(tweet.user?.verified)!
            if let profileUrl = tweet.user?.profileUrl {
                profileImageView.setImageWith(profileUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true
        
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        profileTapGestureRecognizer.delegate = self
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(profileTapGestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.tweetCellDidTapProfileImage?(tweetCell: self)
    }
}
