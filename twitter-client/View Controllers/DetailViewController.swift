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
    
    var tweet: Tweet! {
        didSet {
            print(tweet.text ?? "NO tweet")
            nameLabel.text = tweet.user?.name ?? "NO User"
            handleLabel.text = tweet.user?.handle?
            tweetLabel.text = tweet?.text
            profileImageView.setImageWith((tweet.user?.profileUrl)!)
            timestampLabel.text = String(describing: tweet.timestamp)
            retweetsCountLabel.text = String(tweet.retweetCount)
            likesCountLabel.text = String(tweet.favoritesCount)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
