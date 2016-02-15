//
//  detailsViewController.swift
//  Tweeter
//
//  Created by John Henning on 2/9/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {
    
    var tweet: Tweet?
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLabel.text = tweet?.user?.name
        userLabel.sizeToFit()
        screennameLabel.text = tweet?.user?.screenName
        screennameLabel.sizeToFit()
        retweetLabel.text = "\(tweet!.retweet!)"
        likeLabel.text = "\(tweet!.like!)"
        profileImageView.setImageWithURL((tweet?.user?.profileImageURL)!)
        tweetLabel.text = tweet!.text
        tweetLabel.sizeToFit()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /* 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
