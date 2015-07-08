//
//  SignInViewController.swift
//  CaptionMySocialPic
//
//  Created by VIJAY VENKATESH on 7/7/15.
//  Copyright (c) 2015 VIJAY VENKATESH. All rights reserved.
//

import UIKit
import Accounts
import Social

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // My man
        
    }

    @IBAction func twitterTapped(sender: AnyObject) {
        //constant called account
        //ACA accounts to access social networks - twitter, facebook etc.
        
        let account = ACAccountStore()
        let accountType = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in
            
            if granted{
                
                let allAccounts = account.accountsWithAccountType(accountType)
                if allAccounts.count > 0 {
                    //If at least one account exists
                    let twitterAccount = allAccounts.last as! ACAccount

                    let requestAPI = NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
                    let userRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestAPI, parameters: nil)
                    userRequest.account = twitterAccount
                    userRequest.performRequestWithHandler({ (response: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
                        
                        var error = NSErrorPointer()
                        
                        let responseDictionary = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableLeaves, error: error) as! [String: AnyObject]
                        
                        var imageURL = responseDictionary["profile_image_url_https"] as! String
                        //println(imageURL)
                        
                        imageURL = imageURL.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                        
                        println (imageURL)
                        var imageRequest = NSURLRequest(URL: NSURL(string: imageURL)!)
                        
                        NSURLConnection.sendAsynchronousRequest(imageRequest, queue: NSOperationQueue.mainQueue(), completionHandler: { (imageResponse: NSURLResponse!, imageData: NSData!, imageError:NSError!) -> Void in
                            var image = UIImage(data: imageData)
                            
                            //segue
                            self.performSegueWithIdentifier("SignInToTextSegue", sender: image)
                        })
                        
                    })
                }
            } else {
                println("User did not grant access")
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let addTextViewController = segue.destinationViewController as! AddTextViewController
        addTextViewController.profileImage = (sender as! UIImage)
    }
    

}
