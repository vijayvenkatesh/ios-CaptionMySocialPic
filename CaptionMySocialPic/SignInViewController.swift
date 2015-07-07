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
                        
                        let responseDictionary = NSJSONSerialization.JSONObjectWithData(response, options: <#NSJSONReadingOptions#>, error: <#NSErrorPointer#>)
                    })
                }
            } else {
                println("User did not grant access")
            }
        }
        
    }
    

}
