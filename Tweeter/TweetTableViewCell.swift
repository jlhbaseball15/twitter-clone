//
//  TweetTableViewCell.swift
//  Tweeter
//
//  Created by John Henning on 2/5/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    
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
            profileImageView.clipsToBounds = true;
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
