//
//  TweetTableViewCell.swift
//  Tweeter
//
//  Created by John Henning on 2/5/16.
//  Copyright © 2016 John Henning. All rights reserved.
//
// swiftlint:disable variable_name
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length
import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var isRetweet = false
    var isLiked = false
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text!
            tweetLabel.sizeToFit()
            
            nameLabel.text = tweet.user!.name!
            handleLabel.text = "@\(tweet.user!.screenName!)"
            retweetLabel.text = "\(tweet.retweet!)"
            likeLabel.text = "\(tweet.like!)"

            profileImageView.setImageWithURL((tweet.user?.profileImageURL)!)
            profileImageView.layer.cornerRadius = 3
            profileImageView.clipsToBounds = true
            
            if tweet.isLiked != nil {
                if tweet.isLiked! {
                    likeButton.tintColor = UIColor.redColor()
                    likeLabel.textColor = UIColor.redColor()
                } else {
                    likeButton.tintColor = UIColor.grayColor()
                    likeLabel.textColor = UIColor.grayColor()
                }
            }
            if tweet.isRetweeted != nil {
                if tweet.isRetweeted! {
                    retweetButton.tintColor = UIColor.greenColor()
                    retweetLabel.textColor = UIColor.greenColor()
                } else {
                    retweetButton.tintColor = UIColor.grayColor()
                    retweetLabel.textColor = UIColor.grayColor()
                }
            }
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        isRetweet = !isRetweet
        
        if isRetweet {
            retweetButton.tintColor = UIColor.greenColor()
            retweetLabel.textColor = UIColor.greenColor()
            tweet.retweet = tweet.retweet! + 1
            retweetLabel.text = "\(tweet.retweet!)"

            TwitterClient.sharedInstance.retweetMe(tweet.id!)
        } else {
            retweetButton.tintColor = UIColor.grayColor()
            retweetLabel.textColor = UIColor.grayColor()
            tweet.retweet = tweet.retweet! - 1
            retweetLabel.text = "\(tweet.retweet!)"

            TwitterClient.sharedInstance.unRetweetMe(tweet.id!)
        }
    }

    
    @IBAction func onLike(sender: AnyObject) {
        isLiked = !isLiked
        
        
        if isLiked {
            likeButton.tintColor = UIColor.greenColor()
            likeLabel.textColor = UIColor.greenColor()
            print("test")
            tweet.like = tweet.like! + 1
            likeLabel.text = "\(tweet.like!)"
            TwitterClient.sharedInstance.favoriteMe(tweet.id!)
        } else {
            likeButton.tintColor = UIColor.grayColor()
            likeLabel.textColor = UIColor.grayColor()
            tweet.like = tweet.like! - 1
            likeLabel.text = "\(tweet.like!)"
            TwitterClient.sharedInstance.unFavoriteMe(tweet.id!)
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
