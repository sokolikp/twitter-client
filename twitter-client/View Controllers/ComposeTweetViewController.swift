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
    @IBOutlet weak var charLimitLabel: UILabel!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var respondToTweet: Tweet?
    let placeholder: String = "What's on your mind?"
    let MAX_CHARS: Int = 140
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true
        tweetTextView.delegate = self
        profileImageView.setImageWith((User.currentUser?.profileUrl)!)
        tweetTextView.becomeFirstResponder()
        
        // start in "edit mode" tweeting at a user or set some default state
        if respondToTweet != nil && respondToTweet!.user != nil {
            tweetTextView.text = "@\(respondToTweet!.user!.handle!): "
            let charCount = tweetTextView.text.characters.count
            charLimitLabel.text = "\(charCount)/\(MAX_CHARS)"
            placeholderLabel.isHidden = true
        } else {
            charLimitLabel.text = "0/\(MAX_CHARS)"
            tweetTextView.text = nil
        }
    }
    
    // MARK: delegate handlers
    func textViewDidChange(_ textView: UITextView) {
        let charCount = textView.text.characters.count
        self.charLimitLabel.text = "\(charCount)/\(MAX_CHARS)"
        
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars <= MAX_CHARS
    }
    
    // MARK: action method outlets
    @IBAction func onClickTweet(_ sender: Any) {
        // don't tweet empty message
        if tweetTextView.text.isEmpty {
            return
        }
        
        let replyId = respondToTweet?.id ?? nil
        TwitterClient.sharedInstance.postTweet(message: tweetTextView.text, replyId: replyId, success: { (tweet: Tweet) in
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
