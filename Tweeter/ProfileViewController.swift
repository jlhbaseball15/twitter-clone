//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by John Henning on 2/9/16.
//  Copyright © 2016 John Henning. All rights reserved.
//
// swiftlint:disable variable_name
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var user: User?
    var tweets: [Tweet]?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        
        nameLabel.text = user?.name!
        screennameLabel.text = user?.screenName!
        coverImageView.setImageWithURL((user?.coverImageURL!)!)
        profileImageView.setImageWithURL((user?.profileImageURL)!)
        
        TwitterClient.sharedInstance.userTimelineWithParams((user?.screenName!)!) { (tweets, error) -> () in
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
        let cell = tableView.dequeueReusableCellWithIdentifier("profileTweetCell", forIndexPath: indexPath) as? ProfileTweetTableViewCell
        
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
