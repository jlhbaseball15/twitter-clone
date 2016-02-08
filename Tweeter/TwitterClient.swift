//
//  TwitterClient.swift
//  Tweeter
//
//  Created by John Henning on 2/3/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "8nfqdT5ttlqbrQ5McYnhNrHPG"
let twitterConsumerSecret = "qy83Fs3CEzJ5T6wS3KwJgbAezkARHz1PVL2mBV8DYCHgodor25"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: params, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("home timeline: ")
            //print("user: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            
            
            completion(tweets: tweets, error: nil)
            
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func favoriteMe(id: String) {
        POST("https://api.twitter.com/1.1/favorites/create.json?id=\(id)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Succesfully favorited")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to favorite")
        }
    }
    func unFavoriteMe(id: String) {
        POST("https://api.twitter.com/1.1/favorites/destroy.json?id=\(id)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Succesfully favorited")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to favorite")
        }
    }
    
    func retweetMe(id: String) {
        POST("https://api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully retweeted")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to retweet")
        }
    }
    func unRetweetMe(id: String) {
        POST("https://api.twitter.com/1.1/statuses/unretweet/\(id).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully retweeted")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to retweet")
        }
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        
        //Fetch Request Token & redirect to authorization page
        requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweeter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
        
    }
    
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            
            self.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("It worked!!!")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print(user.name!)
                self.loginCompletion?(user: user, error: nil)
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("It did not work")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            
            
            
            }) { (error: NSError!) -> Void in
                print("An error occurred")
                self.loginCompletion?(user: nil, error: error)
        }

    }
}
