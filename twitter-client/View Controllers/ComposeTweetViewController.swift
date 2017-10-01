//
//  ComposeTweetViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/30/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true
        tweetTextView.delegate = self
        profileImageView.setImageWith((User.currentUser?.profileUrl)!)
        tweetTextView.text = "What's on your mind?"
        tweetTextView.textColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's on your mind?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func onClickTweet(_ sender: Any) {
        TwitterClient.sharedInstance.postTweet(message: tweetTextView.text, replyId: nil, success: { (tweet: Tweet) in
            print("I tweeted! HOly shit")
            self.dismiss(animated: true, completion: nil)
        }) { (error: Error) in
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
