//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by John Henning on 2/4/16.
//  Copyright © 2016 John Henning. All rights reserved.
//
// swiftlint:disable variable_name
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userProfileImageView: UIImageView!

    
    
    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    var params: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        
        
        userProfileImageView.setImageWithURL((User.currentUser?.profileImageURL!)!)
        userProfileImageView.layer.cornerRadius = 3
        userProfileImageView.clipsToBounds = true
        //userHandleLabel.text = User.currentUser?.screenName;
        //userNameLabel.text = User.currentUser?.name
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupRefreshControl() {

        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        refresh(self)
    }
 

    
    func refresh(sender: AnyObject) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        refreshControl?.endRefreshing()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as? TweetTableViewCell
        
        cell!.tweet = tweets![indexPath.row]
        
        return cell!
    }
    
    
    
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailsSegue" {
            let cell = sender as? UITableViewCell
            let indexPath = tableView.indexPathForCell(cell!)
            let tweet = self.tweets[(indexPath?.row)!]
            let detailedTweet = segue.destinationViewController as? DetailsViewController
            detailedTweet!.tweet = tweet
        } else if segue.identifier == "tweetProfileSegue" {
            let button = sender as? UIButton
            let cell = button!.superview?.superview as? UITableViewCell
            let indexPath = tableView.indexPathForCell(cell!)
            let user = self.tweets[(indexPath?.row)!].user
            let userProfile = segue.destinationViewController as? ProfileViewController
            userProfile?.user = user
            
        }
 
    }

}
