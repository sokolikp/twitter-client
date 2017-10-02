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
    
    var respondToTweet: Tweet?
    var pristine: Bool!
    let placeholder: String = "What's on your mind?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true
        tweetTextView.delegate = self
        profileImageView.setImageWith((User.currentUser?.profileUrl)!)
        
        // start in "edit mode" tweeting at a user or set some default state
        if respondToTweet != nil && respondToTweet!.user != nil {
            pristine = false
            tweetTextView.textColor = UIColor.black
            tweetTextView.text = "@\(respondToTweet!.user!.name!): "
            tweetTextView.becomeFirstResponder()
        } else {
            setPristine()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if pristine {
            textView.text = nil
            textView.textColor = UIColor.black
        } else {
            pristine = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPristine()
        }
    }
    
    func setPristine() {
        pristine = true
        tweetTextView.text = placeholder
        tweetTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func onClickTweet(_ sender: Any) {
        // don't tweet placeholder message 
        if pristine {
            return
        }
        
        let replyId = respondToTweet?.id ?? nil
        TwitterClient.sharedInstance.postTweet(message: tweetTextView.text, replyId: replyId, success: { (tweet: Tweet) in
            print("I tweeted! Holy shit")
            self.tweetTextView.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
        }) { (error: Error) in
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        tweetTextView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
