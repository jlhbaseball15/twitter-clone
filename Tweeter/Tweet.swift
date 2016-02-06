//
//  Tweet.swift
//  Tweeter
//
//  Created by John Henning on 2/3/16.
//  Copyright © 2016 John Henning. All rights reserved.
//
import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweet: Int?
    var like: Int?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        like = dictionary["favorite_count"] as! Int
        
        retweet = dictionary["retweet_count"] as! Int
        
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary:  dictionary))
        }
        
        return tweets
    }
}
