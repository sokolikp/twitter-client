//
//  TwitterClient.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/25/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "BVQ4NzypPT5u966wWpezbFvqq"
let twitterConsumerSecret = "xqEWlkKPkr4V348h9GiDew9TOpquR2qQGWvhKJa7u2I9V4y1Vx"
let twitterBaseURL = URL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    var loginSuccess: ((User) -> ())?
    var loginFailure: ((Error) -> ())?

    static let sharedInstance: TwitterClient = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    
    func login(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        requestSerializer.removeAccessToken()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("Got the request token!", requestToken!.token)
            let authURL = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token as String)")
            UIApplication.shared.open(authURL!)
        }) { (error: Error!) in
            print("Error...")
            self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
        print("logged out")
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        self.get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask?, response: Any?) in
            let tweets = Tweet.tweetsWithArray(array: response as! [NSDictionary])
            success(tweets)
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func openUrl(url: URL) {
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential?) in
            print("got the token")
            self.requestSerializer.saveAccessToken(accessToken)
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?(user)
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
        }) { (error: Error!) in
            print("Failed to open access URL")
            self.loginFailure?(error)
        }
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        self.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let user = User(dictionary: response as! NSDictionary)
            print("user \(user.name!)")
            success(user)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("Failed to verify")
            failure(error)
        })
    }
}
