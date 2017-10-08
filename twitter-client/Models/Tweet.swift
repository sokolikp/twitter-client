//
//  Tweet.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/26/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit
var _tweets: [Tweet]?
var _userTweets: [Tweet]?

class Tweet: NSObject {
    var id: Int?
    var user: User?
    var text: String?
    var place: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var retweeted: Bool = false
    var liked: Bool = false
    var retweet: Tweet? // parent tweet id
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        retweeted = (dictionary["retweeted"] as? Bool) ?? false
        liked = (dictionary["favorited"] as? Bool) ?? false
        
        if let retweetObj = dictionary["retweeted_status"] as? NSDictionary {
            retweet = Tweet(dictionary: retweetObj)
        }
        
        let placeObj = dictionary["place"] as? NSDictionary
        if let placeObj = placeObj {
            place = (placeObj["full_name"] as? String) ?? nil
        }
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)! as NSDate
        }
        
    }
    
    func getLikeImage () -> (UIImage) {
        let image: UIImage!
        if self.liked {
            image = UIImage(named: "like-red")
        } else {
            image = UIImage(named: "like-gray")
        }
        
        return image
    }
    
    func getRetweetImage () -> (UIImage) {
        let image: UIImage!
        if self.retweeted {
            image = UIImage(named: "retweet-blue")
        } else {
            image = UIImage(named: "retweet-gray")
        }
        
        return image
    }
    
    // getter-only closure; no ability to set
    class var tweets: [Tweet]? {
        get {
            return _tweets ?? [Tweet]()
        }
    }
    
    class var userTweets: [Tweet]? {
        get {
            return _userTweets ?? [Tweet]()
        }
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        // reset internal tweets array
        var tweetArray: [Tweet] = [Tweet]()
        
        for dictionary in array {
            tweetArray.append(Tweet(dictionary: dictionary))
        }
        
        return tweetArray
    }
    
    class func setTweets(array: [Tweet]) -> () {
        _tweets = array
    }
    
    class func setUserTweets(array: [Tweet]) -> () {
        _userTweets = array
    }
    
    class func appendTweets(array: [Tweet]) -> () {
        _tweets! += array
    }
    
    class func prependToTweets(tweet: Tweet) -> () {
        _tweets?.insert(tweet, at: 0)
    }
    
    class func getTweetIndex(id: Int) -> (Int?) {
        var targetIdx: Int?
        for (index, tweet) in _tweets!.enumerated() {
            if tweet.id == id {
                targetIdx = index
                break
            }
        }
        
        return targetIdx ?? nil
    }
    
    class func getTweet(id: Int) -> (Tweet?) {
        let idx: Int? = getTweetIndex(id: id)
        var tweet: Tweet?
        
        if idx != nil {
            tweet = _tweets?[idx!]
        }
        
        return tweet ?? nil
    }
    
    class func updateTweet(tweet: Tweet) -> () {
        let idx: Int? = getTweetIndex(id: tweet.id!)
        
        if idx != nil {
            _tweets?[idx!] = tweet
        }
    }
    
    class func updateRetweetData(id: Int, retweeted: Bool) -> () {
        let incrementor: Int! = retweeted ? 1 : -1
        let tweet: Tweet? = getTweet(id: id)
        
        if tweet != nil {
            tweet?.retweetCount += incrementor
            tweet?.retweeted = retweeted
        }
    }
    
    class func removeTweet(id: Int) -> () {
        let idx: Int? = getTweetIndex(id: id)
        
        if idx != nil {
            _tweets?.remove(at: idx!)
        }
    }
    
    class func removeTweet(byRetweetId: Int) -> () {
        var targetIdx: Int?
        for (index, tweet) in _tweets!.enumerated() {
            if tweet.retweet?.id == byRetweetId {
                targetIdx = index
                break
            }
        }
        
        if targetIdx != nil {
            removeTweet(id: targetIdx!)
        }
    }
}
