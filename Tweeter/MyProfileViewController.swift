//
//  MyProfileViewController.swift
//  Tweeter
//
//  Created by John Henning on 2/14/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

// swiftlint:disable variable_name
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import UIKit

class MyProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var tweets: [Tweet]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        screenNameLabel.text = User.currentUser?.screenName!
        screenNameLabel.sizeToFit()
        nameLabel.text = User.currentUser?.name!
        nameLabel.sizeToFit()
        
        profileImageView.setImageWithURL((User.currentUser?.profileImageURL)!)
        coverImageView.setImageWithURL((User.currentUser?.coverImageURL)!)
        
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        TwitterClient.sharedInstance.userTimelineWithParams((User.currentUser?.screenName)!) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return (tweets?.count)!
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myProfileTweetCell", forIndexPath: indexPath) as? ProfileTweetTableViewCell
        
        cell!.tweet = tweets![indexPath.row]
        
        return cell!
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
