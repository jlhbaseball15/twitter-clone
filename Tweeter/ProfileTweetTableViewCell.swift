//
//  profileTweetTableViewCell.swift
//  Tweeter
//
//  Created by John Henning on 2/14/16.
//  Copyright © 2016 John Henning. All rights reserved.
//
// swiftlint:disable variable_name
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import UIKit

class ProfileTweetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text!
            tweetLabel.sizeToFit()
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
