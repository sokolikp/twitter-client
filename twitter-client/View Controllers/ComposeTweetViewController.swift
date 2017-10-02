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
    let MAX_CHARS: Int = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds  = true
        tweetTextView.delegate = self
        profileImageView.setImageWith((User.currentUser?.profileUrl)!)
        
        let twitterBlue = UIColor(displayP3Red: CGFloat(0)/255, green: CGFloat(172)/255, blue: CGFloat(237)/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = twitterBlue
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
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
        print("begin")
        if pristine {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            pristine = true
        } else {
            pristine = false
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars <= MAX_CHARS
    }
    
    func setPristine() {
        pristine = true
        tweetTextView.text = placeholder
        tweetTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func onClickTweet(_ sender: Any) {
        print(pristine)
        print("Clicked")
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
