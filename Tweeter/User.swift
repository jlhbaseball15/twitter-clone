//
//  User.swift
//  Tweeter
//
//  Created by John Henning on 2/3/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit

var _currentUser: User?
var currentUserKey = "CurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageURL: NSURL?
    var tagline: String?
    var dictionary: NSDictionary
    var tweets: [Tweet]?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageURL = NSURL(string: (dictionary["profile_image_url"] as? String)!)
        tagline = dictionary["description"] as? String
    }
    
    func logout() {
        User.currentUser = nil;
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                do{
                    let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                    if data != nil {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    }
                }catch let error as NSError{
                    //handle error
                    print("Error : \(error)")
                }
        
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do{
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions(rawValue: 0))
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                }catch let error as NSError{
                    //handle error
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                    print("Error : \(error)")
                }
            }
        }
    }
}
