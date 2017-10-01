//
//  Tweet.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/26/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit
var _tweets: [Tweet]?

class Tweet: NSObject {
    var id: Int?
    var user: User?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var place: String?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
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
    
    class var tweets: [Tweet]? {
        get {
            return _tweets ?? [Tweet]()
        }
        
        set(tweets) {
            _tweets = tweets
        }
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        // reset internal tweets array
        _tweets = [Tweet]()
        
        for dictionary in array {
            _tweets?.append(Tweet(dictionary: dictionary))
        }
        
        return _tweets!
    }
    
    class func prependToTweets(tweet: Tweet) -> () {
        _tweets?.insert(tweet, at: 0)
    }
}
