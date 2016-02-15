//
//  ComposeTweetViewController.swift
//  Tweeter
//
//  Created by John Henning on 2/14/16.
//  Copyright © 2016 John Henning. All rights reserved.
//

import UIKit



class ComposeTweetViewController: UIViewController {
    
    var dictionary: NSDictionary?
    
    @IBOutlet weak var tweetField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSendTweet(sender: AnyObject) {
        let status = tweetField.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)

        TwitterClient.sharedInstance.composeTweet(status)
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        if (tweetField.text?.characters.count > 140){
            print("\(tweetField.text!.characters.count)")
            tweetField.text!.removeAtIndex(tweetField.text!.endIndex.predecessor())
            print("\(tweetField.text!.characters.count)")
        }
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.resignFirstResponder()
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
