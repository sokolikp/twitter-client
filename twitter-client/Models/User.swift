//
//  User.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/26/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

var _currentUser: User?
let _currentUserKey = "CurrentUserKey"

class User: NSObject {
    var id: Int?
    var name: String?
    var handle: String?
    var location: String?
    var profileUrl: URL?
    var backgroundUrl: URL?
    var tagline: String?
    var dictionary: NSDictionary
    var verified: Bool = false
    var followerCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        handle = dictionary["screen_name"] as? String
        location = dictionary["location"] as? String
        let profileUrlString = dictionary["profile_image_url"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        let backgroundUrlString = dictionary["profile_background_image_url"] as? String
        if let backgroundUrlString = backgroundUrlString {
            backgroundUrl = URL(string: backgroundUrlString)
        }
        tagline = dictionary["description"] as? String
        verified = (dictionary["verified"] as? Bool) ?? false
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    class var currentUser: User? {
        get {
            if (_currentUser == nil) {
                let data = UserDefaults.standard.object(forKey: _currentUserKey) as? Data
                if (data != nil) {
                    let dictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if (_currentUser != nil) {
                let data = try! JSONSerialization.data(withJSONObject: _currentUser!.dictionary, options: [])
                
                defaults.set(data, forKey: _currentUserKey)
                defaults.synchronize()
            } else { // log out
                defaults.set(nil, forKey: _currentUserKey)
                defaults.synchronize()
            }
        }
    }
}


